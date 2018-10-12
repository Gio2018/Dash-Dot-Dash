//
//  WatchAudioPlayer.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/9/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import AVFoundation
import Foundation
import WatchKit


/// Handles sounds in any part of the watch app
class WatchAudioPlayer {
    
    private var audioPlayer: AVAudioPlayerNode
    private var musicPlayer: AVAudioPlayer?
    private var audioEngine: AVAudioEngine
    private var audioFile: AVAudioFile?
    
    
    #warning("TODO: make this initializer failable, if the final solution is AVAudioEngine")
    init(with resource: String) {
        audioPlayer = AVAudioPlayerNode()
        audioEngine = AVAudioEngine()
        audioEngine.attach(audioPlayer)
        
        guard let audioFile = audioFile(for: resource) else {
            print("AUDIO MODE ERROR: unable to construct audio file from resource")
            return
        }
        
        self.audioFile = audioFile
        
        do {
            try start(with: audioFile)
        } catch {
            print("Audio player did not start: \(error)")
        }
    }
    
    /// Plays an audio file located at the specified file path
    ///
    /// - Parameters:
    ///   - resource: the file path
    ///   - musicMode: if true, enables the use of AVAudioPlayer instead of AVAudioPlayerNode
    internal func play(from resource: String, musicMode: Bool) {
        if musicMode {
            guard let url = audioFileURL(for: resource) else {
                print("MUSIC MODE ERROR: unable to construct URL from resource")
                return
            }
            do {
                try musicPlayer = AVAudioPlayer(contentsOf: url)
                musicPlayer?.play()
            } catch {
                print("MUSIC MODE ERROR: Failed to initalize player, \(error)")
            }
        }
        else {
            guard let audioFile = self.audioFile else {
                print("AUDIO MODE ERROR: Audio file is nil")
                return
            }
            play(file: audioFile)
        }
    }
    
    /// Starts the AVAudioEngine instance
    ///
    /// - Throws: AVAudioEngine start errors
    private func start(with audioFile: AVAudioFile) throws {
        guard !audioEngine.isRunning else { return }
        let audioFormat = audioFile.processingFormat
        audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFormat)
        try audioEngine.start()
    }
    
    /// Plays an audio file using AVAudioNode
    ///
    /// - Parameter file: the audio file to play
    private func play(file: AVAudioFile) {
        audioPlayer.scheduleFile(file, at: nil, completionHandler: nil)
        audioPlayer.play()
    }
    
    /// Constructs an url from an audio file path
    ///
    /// - Parameter resource: the file path
    /// - Returns: the constructed url or nil, if no valid file path was passed
    private func audioFileURL(for resource: String) -> URL? {
        guard let bundle = Bundle(identifier: "com.gio.Dash-Dot-Dash.watchkitapp.watchkitextension") else {
            return nil
        }
        guard let audioFilePath = bundle.path(forAuxiliaryExecutable: resource) else {
            return nil
        }
        return URL(fileURLWithPath: audioFilePath)
    }
    
    /// Retrieves an audio file from a local resource
    ///
    /// - Parameter resource: the path to the resource
    /// - Returns: the audio resource or nil, if none was found
    private func audioFile(for resource: String) -> AVAudioFile? {
        guard let audioFileUrl = audioFileURL(for: resource) else {
            return nil
        }
        do {
            return try AVAudioFile(forReading: audioFileUrl)
            
        } catch {
            print ("asset error \(error)")
            return nil
        }
    }
}
