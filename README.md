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

There are two additional parameters for further configuration: `language` and `allowsFullScreen`.
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

## Notes

The framework contains both device and simulator modules, so keep in mind that to upload it to the app store, you'll need to add a script to remove the simulator modules for release.
