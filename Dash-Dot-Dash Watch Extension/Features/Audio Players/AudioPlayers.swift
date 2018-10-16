//
//  AudioPlayers.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/16/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import AVFoundation
import WatchKit


// MARK: - AVAudioPlayer conformance to Player
extension AVAudioPlayer: Player {
    
    convenience init?(with filePath: String) {
        guard let audioFilePath = Bundle.main.path(forAuxiliaryExecutable: filePath) else {
            return nil
        }
        
        let url = URL(fileURLWithPath: audioFilePath)
        do {
            try self.init(contentsOf: url)
        } catch {
            return nil
        }
    }
    
    func playAudio(audioFile: AVAudioFile?) {
        self.play()
    }
}


// MARK: - AVAudioPlayerNode conformance to Player
extension AVAudioPlayerNode: Player {
    
    convenience init?(with filePath: String, engine: AVAudioEngine) {
        self.init()
        engine.attach(self)
        guard let file = audioFile(for: filePath) else { return nil }
        let audioFormat = file.processingFormat
        engine.connect(self, to: engine.mainMixerNode, format: audioFormat)
        do {
            try engine.start()
            
        } catch {
            print("Audio player did not start: \(error)")
            return nil
        }
    }
    
    func playAudio(audioFile: AVAudioFile?) {
        guard let file = audioFile else { return }
        self.scheduleFile(file, at: nil, completionHandler: nil)
        self.play()
    }
    
    
    /// Retrieves an audio file from a local resource
    ///
    /// - Parameter resource: the path to the resource
    /// - Returns: the audio resource or nil, if none was found
    internal func audioFile(for resource: String) -> AVAudioFile? {
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


// MARK: - WKAudioFilePlayer conformance to Player
extension WKAudioFilePlayer: Player {
    
    convenience init?(with filePath: String) {
        guard let audioFilePath = Bundle.main.path(forAuxiliaryExecutable: filePath) else {
            return nil
        }
        
        let url = URL(fileURLWithPath: audioFilePath)
        let asset = WKAudioFileAsset(url: url)
        let playerItem = WKAudioFilePlayerItem(asset: asset)
        self.init(playerItem: playerItem)
    }
    
    func playAudio(audioFile: AVAudioFile?) {
        self.play()
    }
}
