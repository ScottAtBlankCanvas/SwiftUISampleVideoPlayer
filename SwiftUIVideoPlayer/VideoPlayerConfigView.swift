//
//  VideoPlayerConfigView.swift
//  SwiftUIVideoPlayer
//
//  Created by scott on 8/2/23.
//

import SwiftUI

struct VideoPlayerConfigView: View {
    @Binding var config: VideoPlayerConfig
    
    var body: some View {
        NavigationStack {
              VStack {
                  
                  TextField(
                       "URL",
                       text: $config.url
                   )
                   .onSubmit {
                       print("onSubmit")
                       //TODO: validate the URL validate(name: url)
                   }
                   .textInputAutocapitalization(.never)
                   .disableAutocorrection(true)
                   .border(.secondary)
   
              }
          }
    }
}

 struct VideoURLSelectorView_Previews: PreviewProvider {
     static var previews: some View {
         VideoPlayerConfigView(config: .constant(VideoPlayerConfig()))
     }
 }
 
