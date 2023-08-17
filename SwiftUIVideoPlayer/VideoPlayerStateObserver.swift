//
//  VideoPlayerStateObserver.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/10/23.
//

import Foundation
import AVKit

class VideoPlayerStateObserver : ObservableObject {
    @Published var status: String = ""
    @Published var error: String = ""

    var player: AVPlayer?
    private var playerObserver: Any?
    private var playerItemObserver: Any?
    private var timeControlStatusObserver: Any?
 
    func updateStatus(status: String) {
        if (self.status != status) {
            self.status = status
        }
    }
 
    func updateError(err: String) {
        if (self.error != err) {
            self.error = err
        }
    }

    
    func connectPlayer(newPlayer: AVPlayer) {
        player = newPlayer
        
        setupObservers()
    }

    
    func handleError() {
        // Apple docs are a bit unclear.  Errors can be one of 3 places
        // AVPlayerItem, AVPlayer or in ErrorQueue
        if let error = player?.currentItem?.error as NSError? {
            updateError(err: "\(error.domain): \(error.code)")
        } else if let error = player?.error as NSError? {
            updateError(err: "\(error.domain): \(error.code)")
        } else {
            if let errorLog = player?.currentItem?.errorLog() {
                for event:AVPlayerItemErrorLogEvent in errorLog.events {
                    updateError(err: "\(event.errorDomain): \(event.errorStatusCode)")

                    // only first one needed, so...
                    break
                }
            }
        }
    }

    
    private func setupObservers() {
        timeControlStatusObserver = player?.observe(\.timeControlStatus, options: [.new], changeHandler: {
                [weak self] (player, change) in

            if (player.timeControlStatus  == AVPlayer.TimeControlStatus.paused) {
                self?.updateStatus(status: "Paused")
            } else if (player.timeControlStatus == AVPlayer.TimeControlStatus.waitingToPlayAtSpecifiedRate) {
                self?.updateStatus(status: "Waiting")
            } else if (player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
                self?.updateStatus(status: "Playing")
            }
        })
 
        // Apple revommends listening to both player and playerItem to capture errors
        
        playerObserver = player?.observe(\AVPlayer.status, options:  [.new], changeHandler: {
            [weak self] (player, change) in

            if player.status == .failed {
                self?.handleError()
            }

        })
            
        playerItemObserver = player?.currentItem?.observe(\.status, options:  [.new], changeHandler: {
            [weak self] (playerItem, change) in

            if playerItem.status == .failed {
                self?.handleError()
            }

        })
         
    
     }
    
}



