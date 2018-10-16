//
//  WatchAudioPlayer.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/9/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import AVFoundation
import WatchKit


/// Plays a sound file with any of the available player types
class WatchAudioPlayer {
    
    var player: Player
    var engine: AVAudioEngine?
    var audioFile: AVAudioFile?
    
    init?(with filePath: String, playerType: PlayerType) {
        switch playerType {
        case .avPlayer:
            guard let player = AVAudioPlayer(with: filePath) else { return nil }
            self.player = player
        case .avNode:
            engine = AVAudioEngine()
            guard let player = AVAudioPlayerNode(with: filePath, engine: engine!) else { return nil }
            audioFile = player.audioFile(for: filePath)
            self.player = player
        case .wkPlayer:
            guard let player = WKAudioFilePlayer(with: filePath) else { return nil }
            self.player = player
        }
    }
    
    /// Plays the audiofile with the selected player type
    func playAudio() {
        player.playAudio(audioFile: audioFile)
    }
}
