//
//  VideoPlayerStatus.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/10/23.
//

import Foundation
import AVKit

class VideoPlayerStatus : ObservableObject {
    @Published var status: String = ""
    @Published var error: String = ""

    var player: AVPlayer?
    
    private var statusObserver: Any?
    private var timeControlStatusObserver: Any?
    
    func replacePlayer(newPlayer: AVPlayer) {
        teardownObservers()
         
        player = newPlayer
        
        setupObservers()
    }
    
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

    
    private func teardownObservers() {
//        //print("teardownObservers")
//        if let timeObserver {
//            print("remove timeobserver");
//            player?.removeTimeObserver(timeObserver)
//        }
    }
    
    private func setupObservers() {
 //       print("setupObservers")

         
//        // Observe the player's time periodically so we can update the seek bar's
//        // position as we progress through playback
//        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 2.0, preferredTimescale: 600), queue: nil) { [/*weak*/ self] time in
////                        guard let self = self else { return }
//            //print("time")
//            //print(player.currentTime().seconds)
//         }
//
  
        timeControlStatusObserver = player?.observe(\.timeControlStatus, options: [.old, .new], changeHandler: {
                [weak self] (player, change) in

            if (player.timeControlStatus  == AVPlayer.TimeControlStatus.paused) {
                self?.updateStatus(status: "Paused")
            } else if (player.timeControlStatus == AVPlayer.TimeControlStatus.waitingToPlayAtSpecifiedRate) {
                self?.updateStatus(status: "Waiting")
            } else if (player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
                self?.updateStatus(status: "Playing")
            }
            //print(self?.status)
            })
 

        statusObserver = player?.currentItem?.observe(\.status, options:  [.new, .old], changeHandler: {
            [weak self] (playerItem, change) in
            if playerItem.status == .failed {
                print("AvPlayerItem.Status: failed")
 
                if let error = playerItem.error as NSError? {
                     let errorCode = error.code
                    self?.updateError(err: "\(errorCode)")

                } else {
                    self?.updateError(err: "\(playerItem.error )")
                }
            }

        })
    
     }
    
}



