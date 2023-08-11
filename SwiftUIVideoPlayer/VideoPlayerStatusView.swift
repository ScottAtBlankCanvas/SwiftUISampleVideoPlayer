//
//  VideoPlayerStatusView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/10/23.
//

import SwiftUI

struct VideoPlayerStatusView: View {
    /*@Binding*/ @ObservedObject var status: VideoPlayerStatus
    var body: some View {
        Text("Status: \(status.status)")
    }
}
/*
struct VideoPlayerStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerStatusView(status: .constant(VideoPlayerStatus()))
    }
}
*/

