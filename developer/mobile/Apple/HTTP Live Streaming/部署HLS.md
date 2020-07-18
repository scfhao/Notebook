最简单的部署HLS的方式是创建一个包含HTML5<video>标签的网页，使用.M3U8文件作为视频源。如：
<video src=“http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8” height=“300” width=“400”></video>.
对于不支持HTML5的浏览器，参见Safari HTML5 Audio and Video Guide。

## 配置

HLS可以在普通的web服务器上分发，只需要配置一下相关文件的MIME类型即可。
.M3U8 - application/x-mpegURL或vnd.apple.mpegURL
.ts - video/MP2T

## 验证

mediastreamvalidator是一个用来验证HLS流的命令行工具。它模拟HLS会话，验证序号文件和媒体分段文件是否遵从HLS规格。如果找到错误或问题，可以展示一个详细的诊断报告。

$ mediastreamvalidator -d iphone http://devimages.apple.com/iphone/samples/bipbop/gear3/prog_index.m3u8

### 通过HTTPS安全的提供密钥文件

可以通过加密来保护你的媒体内容。文件分段器和流分段器都有加密选项，而且你还可以制定加密密钥变化规律，然后自主选择将密钥分享给哪些人。

密钥文件需要一个初始的向量（IV）来解密被加密的媒体。IV也可以像密钥一样周期性改变。为了减少开销，推荐每隔3-4小时修改一次密钥，每隔50Mb修改一次IV。

尽管访问密钥时可以加访问控制，然而如果访问密钥操作是通过HTTP时，密钥还是有可能被监听获取。解决这个问题的方法就是通过HTTPS发送密钥。

在通过HTTPS提供密钥前，你应该先在一个内部的web服务器上通过HTTP测试一下密钥服务。这样你可以在添加HTTPS前debug之前的配置。当你确定你的系统可以工作后，就可以切换到HTTPS上了。

使用HTTPS提供HLS的密钥时，你必会遇到以下三个情况：

- 你需要在你的HTTPS服务器上安装一个被信任的机构颁发的SSL证书。
- 密钥文件的验证域名必须和第一个播放列表文件所在的域名一致。完成这件任务的最简单的方式是在同一个HTTPS服务器上发布不同的播放列表文件，每个播放列表文件都只会被下载一次，所以这也不会带来太大的负担。而其他的播放列表文件通过HTTP发布。
- 你必须开始你自己的用户验证对话，或者在客户端设备上存储授权。HLS不提供用户验证对话。如果你是写自己的客户端app，你可以使用保存授权的方法，可以基于cookie或者基于HTTP摘要然后在didReciveAuthenticationChallenge回调（详见Using NSURLConnection和Authentication Challenges and TLS Chain Validation）来提供授权。你提供的授权会被播放器缓存重用。

重要：在HTTPS服务器上使用HLS时，必须使用受信机构颁发的SSL证书。
如果你的HTTPS服务器没有可信机构颁发的SSL证书，你仍可以使用自签名SSL证书来测试你的设置。将CA证书作为邮件附件发送到客户端设备上，点击邮件附件来使设备信任该服务器。

[用于HLS的播放列表文件示例](https://developer.apple.com/library/content/technotes/tn2288/_index.html#//apple_ref/doc/uid/DTS40012238)和[MPEG-2 Stream Encryption Format for HTTP Live Streaming](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/HLS_Sample_Encryption/Intro/Intro.html).


