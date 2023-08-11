# SwiftUIVideoPlayer
A Simple SwiftUI Video Player

## Background
I've done a lot of video work, but very little iOS app development.  And I've never use Swift.
My goal was to complete a simple video player app to learn the basics of SwiftUI, the Swift languages, and engaging with AVPlayer

It turns out, that its simple to shove a Video Player into a SwiftUI App and play back a video via URL.  There are many 50 line projects online that show it.

I wanted to ensure I went deeper and answered these questions during the exercise:
- Create multiple views, so I understand how to create independent Views that build into an app
- Cleanly separate Model and View code, listening for Model changes
- Observe AVPlayer state changes and report this dynamically on the app


## Requirements
The App will be a non-trivial skeleton for creating a Video Player.  It will consist of 3 views:
- A config view that configures what is to be played
- A Play button to load the player and play what is configured
- A video player that will play the video
- A status view that shows Player status as it changes, including any error state

## Resources

### Background Concepts
So to do this I would first need some background concepts.  For example: what is the SwiftUI model?  How does thee Swift language work?  How do I create an iniytiate a player in AVFoundation?

These were very helpful to understand the concepts:
- [SwiftUI concepts](https://developer.apple.com/tutorials/swiftui-concepts)
- [Swift Language Tour](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour)
- [AVFoundation and Media Playback](https://developer.apple.com/documentation/avfoundation/media_playback)

### More helpful resources

I got stuck trying to listen to AVPlayer status changes in a class and ensuring the changes gets broadcast back to my Status View.  [This article explains ObservableObject and State](https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject) and helped me stop conflating the concepts


