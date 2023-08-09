//
//  VideoURLSelectorView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/1/23.
//

import SwiftUI

struct VideoURLSelectorView: View {
 
    @State private var url: String = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    //                    "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!
    //                    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!

    var body: some View {
        NavigationStack {
            VStack {
                
                TextField(
                     "URL",
                     text: $url
                 )
                 .onSubmit {
                     print("onSubmit")
                     //TODO: validate the URL validate(name: url)
                 }
                 .textInputAutocapitalization(.never)
                 .disableAutocorrection(true)
                 .border(.secondary)
 
                Button("Play") {
                    print("Play!")
                    // change model??
                }

            }
        }
    }
}

struct VideoURLSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        VideoURLSelectorView()
    }
}
