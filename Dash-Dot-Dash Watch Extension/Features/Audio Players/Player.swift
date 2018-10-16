//
//  PlayerType.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/15/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import AVFoundation
import UIKit
import WatchKit


/// Player type classification
enum PlayerType: Int {
    case avPlayer = 0
    case avNode = 1
    case wkPlayer = 2
}


/// Conform any player in order to use it in this app
protocol Player {
    /// Retrieves the audio file url
    ///
    /// - Parameter resource: url string
    /// - Returns: audio file url or nil, if no valud url was found
    func audioFileURL(for resource: String) -> URL?
    /// Plays the audio file
    ///
    /// - Parameter audioFile: optional audio file (if needed for pre-playing operations)
    func playAudio(audioFile: AVAudioFile?)
}


// MARK: - Convenience methods
extension Player {
    /// Constructs an url from an audio file path
    ///
    /// - Parameter resource: the file path
    /// - Returns: the constructed url or nil, if no valid file path was passed
    func audioFileURL(for resource: String) -> URL? {
        guard let audioFilePath = Bundle.main.path(forAuxiliaryExecutable: resource) else {
            return nil
        }
        return URL(fileURLWithPath: audioFilePath)
    }
}
