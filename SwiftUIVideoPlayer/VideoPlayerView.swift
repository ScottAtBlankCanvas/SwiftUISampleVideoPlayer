//
//  VideoPlayerView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/1/23.
//

import SwiftUI

import AVKit

// TODO: do play after URL is ready and use replace current item.  Ex:
//avPlayer.replaceCurrentItem(with: playerItem)
//observer = playerItem.observe(\.status) { [weak self] (item, _) in
//    switch item.status {
//    case .readyToPlay:
//        self?.avPlayer.play()
//    case .failed:
//        // handle item.error
//    default:
//        break
//}

struct VideoPlayerView: View {
 
/* TODO: turn off silent mode??
    do { try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        
    } catch { print("Setting category to AVAudioSessionCategoryPlayback failed.")
        
    }
*/
    @State private var config: VideoPlayerConfig = VideoPlayerConfig();
    
    @State private var timeObservation: Any?
    @State private var statusObserver: Any?

    @State var player = AVPlayer()

    var body: some View {
        NavigationStack {
            VStack {
                VideoPlayer(player: player)
                    .scaledToFit()

                VideoPlayerConfigView(config: $config)
                 
                Button("Play") {
                    print("Play!")
                    //config.doPlay()
                    // change model??

                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: config.url)!))
 
                    //observer = playerItem.observe(\.status) { [weak self] (item, _) in
                    //    switch item.status {
                    //    case .readyToPlay:
                    //        self?.avPlayer.play()
                    //    case .failed:
                    //        // handle item.error
                    //    default:
                    //        break
                    //}

 
                    // Observe the player's time periodically so we can update the seek bar's
                    // position as we progress through playback
                    timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 2.0, preferredTimescale: 600), queue: nil) { [/*weak*/ self] time in
//                        guard let self = self else { return }
                        //print("time")
                        //print(player.currentTime().seconds)
                     }

                    
                    statusObserver = player.currentItem?.observe(\.status, options:  [.new, .old], changeHandler: {
                        (playerItem, change) in
                        print(playerItem.status.rawValue)
                        if playerItem.status == .unknown {
                            print("AvPlayerItem.Status: unknown")
                        }
                        else if playerItem.status == .readyToPlay {
                            print("AvPlayerItem.Status: readyToPlay")
                        }
                        else if playerItem.status == .failed {
                            print("AvPlayerItem.Status: failed")
                        }
  
                    })

//                     addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, context: <#T##UnsafeMutableRawPointer?#>)
                    // start play on submit
                    player.play()
                    
                    // TODO: Listen to change events
                    // https://stackoverflow.com/questions/51869313/ios-getting-current-avplayeritem-state
                }

 
             }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
