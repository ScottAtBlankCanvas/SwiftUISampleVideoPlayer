//
//  VideoPlayerView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/1/23.
//

import SwiftUI

import AVKit


struct VideoPlayerView: View {
 
/* TODO: turn off silent mode??
    do { try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        
    } catch { print("Setting category to AVAudioSessionCategoryPlayback failed.")
        
    }
*/
    private var player = AVPlayer()
    @State private var config: VideoPlayerConfig = VideoPlayerConfig()
    @StateObject private var status: VideoPlayerStatus = VideoPlayerStatus()
 
    func initAndPlay(config: VideoPlayerConfig) {
       player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: config.url)!))
       
       status.connectPlayer(newPlayer: player)
        
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


                VideoPlayerStatusView(status: status)
                 
 
             }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
