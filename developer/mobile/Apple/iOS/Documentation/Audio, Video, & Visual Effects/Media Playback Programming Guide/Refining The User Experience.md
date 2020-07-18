## Presenting Chapter Markers

## Selecting Media Options

## Working with the iOS Audio Environment

### Playing Background Audio

要使应用可以在后台播放音频，可以参考[Configuring Audio Settings for iOS and tvOS]中描述的为应用配置能力(capabilities)和音频会话(audio session)。

如果是播放只有音频的资源，如 MP3 或 M4A 文件，做好上面的配置就可以在后台播放音频了。如果你是要在后台播放一个视频的音频部分，那么还需要做一点额外的工作。当应用退到后台时，如果播放器(AVPlayer)正在播放一个视频，播放会自动暂停。如果想让应用退到后台后继续播放音频，可以在应用进到后台时断开 AVPlayer 对象和 界面部分的连接，应用会到前台后在重新建立这个连接：

```
func applicationDidEnterBackground(_ application: UIApplication) {
    // 断开 AVPlayer 与界面
 
    // 通过 AVPlayerViewController 展示图像的情况
    playerViewController.player = nil
 
    // 通过 AVPlayerLayer 展示图像的情况
    playerLayer.player = nil
}
 
func applicationWillEnterForeground(_ application: UIApplication) {
    // 应用回到前台后重新建立 AVPlayer 与界面部分的连接
 
    // 通过 AVPlayerViewController 展示图像的情况
    playerViewController.player = player
 
    // 通过 AVPlayerLayer 展示图像的情况
    playerLayer.player = player
}
```

