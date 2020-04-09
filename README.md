# IN THE GAME iOS Brightcove SDK

This SDK allows you to easily integrate the In The Game engagement platform in an iOS app using the Brightcove video player.
The repository includes an example app that shows how to use the framework.
To run the example, add your BrightCove info and videoID to the `HomeViewController`, and run `pod install` on the terminal to install Brightcove from CocoaPods.


## Installation

To install, simply drag the **InTheGameBC.framework** file into your project. 

Configure the framework as Embedded on your project target settings:

![](https://i.imgur.com/GsuJVIc.png)

And import the SDK in your code:

`import InTheGameBC`

You will need to have the Brightcove SDK in your project. Our example installs the dynamic framework version via CocoaPods - please use this method if you encounter any issues.

## Usage

To quickly show a full-screen controller of your interactive video channel:

```
let controller = ITGBCPlayerViewController.instantiate(videoID: bcVideoID, accountID: bcAccountID, policyKey: bcPolicyKey, broadcasterName: <your_itg_broadcaster_name>)
present(controller, animated: true, completion: nil)
```

To load the video channel in a view to fit your custom layout, load the `ITGBCPlayerView` instead, and then add it as a subview (with constraints as needed): 

```
let playerView = ITGBCPlayerView.instantiate(videoID: bcVideoID, accountID: bcAccountID, policyKey: bcPolicyKey, broadcasterName: <your_itg_broadcaster_name>)
```

There are additional parameters for further configuration: `language`, `allowsFullScreen` and `devMode`.
You can set `devMode` to true to use the development environment. If not specified, production environment is used as ther default.
You can run the included project for a pratical implementation example.

## Manual mode

If you need a custom configuration when loading the Brightcove player, we included a manual mode on the `ITGBCPlayerView`. In this mode the video will not load automatically and you can run your own video loading code.

Load the player view as:
```
let playerView = ITGBCPlayerView.instantiateManualConfig(videoID: bcVideoID, broadcasterName: <your_itg_broadcaster_name>)
```
And after configuring the player view, add your video code:
```
let service = BCOVPlaybackService(accountId: bcAccountID, policyKey: bcPolicyKey)
        service?.findVideo(withVideoID: bcVideoID, parameters: nil, completion: { (video, response, error) in
            if let video = video {
                self.playerView?.videoController.setVideos([video] as NSFastEnumeration)
                self.playerView?.videoController.play()
            }
        })
```
## Overlay mode

The overlay option allows for maximum flexibility - you create a view for the ITG interactive Overlay and position it over your video player as you see fit.
You can create it as:
```
let overlay = ITGOverlayView(videoID: bcVideoID, broadcasterName: <your_itg_broadcaster_name>")
```
And you can attach it to your Brightcove player (so that it gets updates on video playback) like this:
```
videoController.add(overlay)
```
Alternatively, if you don't want to attach it to the player, you can send playback updates manually to the overlay:
```
overlay.videoPlaying()
overlay.videoPaused()
overlay.videoStopped()
overlay.updateVideoTime(seconds: 60)
```

The overlay content will be sized to take the available space while fitting a specified video aspect. The default is the standard 16:9. For other video formats, you can set the aspect ratio as:
```
overlay.setAspectRatio(4/3)
```

The overlay will only assume touch events when they are over its content. Touches on the empty area will be passed to the next view, useful for video controls.

You can check the `OverlayExampleViewController` in the example app for an integration sample.

## Notes

The framework contains both device and simulator modules, so keep in mind that to upload it to the app store, you'll need to add a script to remove the simulator modules for release.
