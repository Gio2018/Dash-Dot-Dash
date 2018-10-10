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
    var hapticSequence: [WKHapticType]
    var playSound: Bool
    var playHaptic: Bool
    var musicMode: Bool
}


/// Renders an audio + haptic sequence dictionary
class SequencePlayer {
    
    private let audioPlayer = WatchAudioPlayer()
    
    private var config = SequenceConfig(soundFile: "",
                               hapticSequence: [],
                               playSound: false,
                               playHaptic: false,
                               musicMode: false)
    
    
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
        }
        if let musicMode = userInfo["musicMode"] as? Bool {
            config.musicMode = musicMode
        }
        if let hpticSequenceValues = userInfo["hapticSequence"] as? [Int] {
            hpticSequenceValues.forEach {
                if let type = WKHapticType(rawValue: $0) {
                    config.hapticSequence.append(type)
                }
            }
        }
    }
    
    /// Executes the requested sequence, based on the stored configuration
    internal func execute() {
        if config.playSound {
            DispatchQueue.main.async {
                self.audioPlayer.play(from: self.config.soundFile, musicMode: self.config.musicMode)
            }
        }
        
        if config.playHaptic {
            var delay: TimeInterval = 0.0
            config.hapticSequence.forEach { type in
                Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {_ in
                    WKInterfaceDevice.current().play(type)
                }
                delay += 0.6
            }
        }
    }
}
