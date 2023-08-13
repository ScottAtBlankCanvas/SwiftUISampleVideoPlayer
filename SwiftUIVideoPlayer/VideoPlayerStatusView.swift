//
//  VideoPlayerStatusView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/10/23.
//

import SwiftUI

struct VideoPlayerStatusView: View {
    @ObservedObject var status: VideoPlayerStateObserver
    var body: some View {
        Text("Status: \(status.status)")
        Text("Error: \(status.error)")
    }
}
/*
struct VideoPlayerStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerStatusView(status: .constant(VideoPlayerStatus()))
    }
}
*/

