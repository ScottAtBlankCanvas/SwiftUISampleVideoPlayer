//
//  VideoPlayerStatus.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/10/23.
//

import Foundation
import AVKit

class VideoPlayerStatus : ObservableObject {
    var player: AVPlayer?
    @Published var status: String = "Foo"
    
    private var timeObserver: Any?
    private var statusObserver: Any?
    private var timeControlStatusObserver: Any?
    private var errorObserver: Any?

    private var playerStatusToken: Any?
    
    
    func replacePlayer(newPlayer: AVPlayer) {
        teardownObservers()
         
        player = newPlayer
        
        setupObservers()
    }
    
    func updateStatus(status: String) {
        self.status = status
    }
  
    
    private func teardownObservers() {
        //print("teardownObservers")
        if let timeObserver {
            print("remove timeobserver");
            player?.removeTimeObserver(timeObserver)
        }
        // TODO  player?.currentItem?.
    }
    
    private func setupObservers() {
        print("setupObservers")

        // TODO: scaffold new player here
        
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
            print(self?.status)
            })
 

        statusObserver = player?.currentItem?.observe(\.status, options:  [.new, .old], changeHandler: {
            [weak self] (playerItem, change) in
            print(playerItem.status.rawValue)
            if playerItem.status == .unknown {
                print("AvPlayerItem.Status: unknown")
            }
            else if playerItem.status == .readyToPlay {
                print("AvPlayerItem.Status: readyToPlay")
            }
            else if playerItem.status == .failed {
                print("AvPlayerItem.Status: failed")
                print(self?.player?.currentItem?.error)

                self?.updateStatus(status: "Error \(self?.player?.currentItem?.error.debugDescription)")
                print(self?.status)
            }

        })
        
        
//                            // TODO: Listen to change events
//                            // https://stackoverflow.com/questions/51869313/ios-getting-current-avplayeritem-state
//                        }


    }
    
}



