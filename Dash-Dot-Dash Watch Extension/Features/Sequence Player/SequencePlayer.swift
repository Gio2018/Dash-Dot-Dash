//
//  SequencePlayer.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/10/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import Foundation
import WatchKit


/// Configuration parameters for an audio + haptic sequence
struct SequenceConfig {
    var soundFile: String
    var hapticSequence: [Int]
    var playSound: Bool
    var playHaptic: Bool
    var musicMode: Bool
    var sequenceInterval: TimeInterval
}


/// Renders an audio + haptic sequence dictionary
class SequencePlayer {
    
    private var audioPlayer: WatchAudioPlayer?
    
    private var config = SequenceConfig(soundFile: "",
                               hapticSequence: [],
                               playSound: false,
                               playHaptic: false,
                               musicMode: false,
                               sequenceInterval: 0.6)
    
    
    /// Sets the desired sequence configuration
    ///
    /// - Parameter userInfo: configuration dictionary
    internal func setConfiguration(userInfo: [AnyHashable : Any]) {
        
        if let playSound = userInfo["playSound"] as? Bool {
            config.playSound = playSound
        }
        if let playHaptic = userInfo["playHaptic"] as? Bool {
            config.playHaptic = playHaptic
        }
        if let soundFile = userInfo["soundFile"] as? String {
            config.soundFile = soundFile
            audioPlayer = WatchAudioPlayer(with: soundFile)
        }
        if let musicMode = userInfo["musicMode"] as? Bool {
            config.musicMode = musicMode
        }
        if let hapticSequence = userInfo["hapticSequence"] as? [Int] {
            config.hapticSequence = hapticSequence
        }
        if let sequenceInterval = userInfo["sequenceInterval"] as? TimeInterval {
            config.sequenceInterval = sequenceInterval
        }
    }
    
    internal func initAudio() {
        
    }
    
    /// Executes the requested sequence, based on the stored configuration
    internal func execute() {
        if config.playSound {
            DispatchQueue.main.async {
                self.audioPlayer?.play(from: self.config.soundFile, musicMode: self.config.musicMode)
            }
        }
        
        if config.playHaptic {
            var delay: TimeInterval = 0.0
            config.hapticSequence.forEach { sequenceValue in
                
                switch sequenceValue {
                case -1:
                    delay += config.sequenceInterval
                default:
                    if let type = WKHapticType(rawValue: sequenceValue) {
                        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {_ in
                            WKInterfaceDevice.current().play(type)
                        }
                    }
                }
                delay += config.sequenceInterval
            }
        }
    }
}
