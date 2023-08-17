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
    private var statusObserver: Any?
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
 

        statusObserver = player?.currentItem?.observe(\.status, options:  [.new], changeHandler: {
            [weak self] (playerItem, change) in
            if playerItem.status == .failed {
                print("AvPlayerItem.Status: failed")
 
                if let error = playerItem.error as NSError? {
                     let errorCode = error.code
                    self?.updateError(err: "\(errorCode)")
                } else { // TODO: handle other error types gracefully
                    self?.updateError(err: "\(playerItem.error )")
                }
            }

        })
    
     }
    
}



