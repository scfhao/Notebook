# 工具下载

这里有一些配置HLS的工具，包括流媒体分段器、媒体文件分段器、流验证器、id3标签生成器和一个播放列表生成器。
这些工具会经常更新，如果你是参与了iOS开发者计划，你可以从苹果开发者网站下载这些工具的最新版本，登录developer.apple.com后，使用搜索功能就可以找到了。(文档里说的轻松，妈蛋让我好找，这些工具实际都在一个dmg包里：HTTP Live Streaming Tools)

## 流媒体分段器

mediastreamsegmenter命令行工具以MPEG-2传输流为输入，会输出一些列长度相同的文件用于HLS。它也可以生成序号文件（也叫播放列表文件）、加密媒体、生成加密密钥、通过reducing overhead优化文件，并为自动生成多个可选流创建必要的文件。如果你安装了这个工具，可以在终端窗口输入man mediastreamsegmenter来获取更详细的信息。
使用示例：mediastreamsegmenter -s 3 -D -f /Library/WebServer/Documents/stream 239.4.1.5:20103
上面的用法示例会从网络上地址为239.4.1.5:20103的地方获取一个直播流，然后创建媒体分段文件和序号文件。这个序号文件中包含当前的三个媒体片段文件列表(-s 3)。这些媒体文件在使用后会被删除(-D)。序号文件和媒体分段文件会被保存在/Library/WebServer/Documents/stream路径下。

## 媒体文件分段器

mediafilesegmenter命令行工具以编码媒体文件为输入，将其转换为一个MPEG-2传输流，然后输出一系列等长度的文件用于HLS。媒体文件分段器也可以输出序号文件和密钥。媒体文件分段器的作用和流分段器十分相似。可以在终端输入man mediafilesegmenter来获取更详细信息。

## 流媒体验证器

mediastreamvalidator命令行工具检查服务器上的序号文件、备用流和媒体分段文件并测试它们是否可以用于HLS客户端。可以在终端窗口输入man mediastreamvalidator来获取关于此工具更详细的信息。

## 可变播放列表生成器

variantplaylistcreator命令行工具创建一个总的序号文件或播放列表，监听mediafilesegmenter工具输出的不同比特率的流。mediafilesegmenter必须使用-generate-variant-playlist参数来生成可变播放列表生成器规定的输出。可以在终端输入man variantplaylistcreator查看详细信息。

## 媒体标签生成器

id3taggenerator命令行工具生成ID3媒体数据标签。这些标签可以写入一个文件或插入正在生成的流片段中。

#会话类型

HLS协议支持两种类型的会话：events（直播）和点播（VOD）。

## VOD会话

对于点播会话，演绎的整个时长内的媒体文件都是可用的。其序号文件是静态的且包含了从演绎开始的所有文件列表。这种会话允许客户端编程的随机的访问整个媒体。

点播也可用用于分发预录的媒体。HLS提供了逐步下载点播的好处，正如对媒体加密和动态根据连接的速度在不同的数据比率的流之间切换的特性。（QuickTime对分步下载的影片也支持多数据率切换，但QuickTime影片不支持动态的在电影中部切换数据率。

## 直播会话

直播会话（events）可用
