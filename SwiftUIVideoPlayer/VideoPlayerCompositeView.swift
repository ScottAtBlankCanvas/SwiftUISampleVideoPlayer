//
//  VideoPlayerCompositeView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/1/23.
//

import SwiftUI

import AVKit


struct VideoPlayerCompositeView: View {
 
/* TODO: turn off silent mode??
    do { try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        
    } catch { print("Setting category to AVAudioSessionCategoryPlayback failed.")
        
    }
*/
    private var player = AVPlayer()
    @State private var config: VideoPlayerConfig = VideoPlayerConfig()
    @StateObject private var playerState: VideoPlayerStateObserver = VideoPlayerStateObserver()
 
    func initAndPlay(config: VideoPlayerConfig) {
       player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: config.url)!))
       
       playerState.connectPlayer(newPlayer: player)
        
       player.play();
    }

    var body: some View {
        NavigationStack {
            VStack {
                VideoPlayerConfigView(config: $config)
                
                Button("Play") {
                    initAndPlay(config: config)
                }

                VideoPlayer(player: player)
                 .frame(width: 320, height: 180, alignment: .center)


                VideoPlayerStatusView(status: playerState)
                 
 
             }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerCompositeView()
    }
}
