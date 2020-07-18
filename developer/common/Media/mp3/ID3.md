找了段代码：

```
AVURLAsset *asset = [AVURLAsset URLAssetWithURL:mp3URL options:nil];
for (NSString *format in [asset availableMetadataFormats]) {
    NSLog(@"%@", format);
    for (AVMetadataItem *data in [asset metadataForFormat:format]) {
        NSLog(@"    %@: %@", data.commonKey, data.value);
    }
}
```

使用的测试mp3文件为张悬的Original专辑中的讨人厌的字。运行代码，找到一个format为`org.id3`，此format下的属性有：
artwork、albumName、title、artist。还有几个没有名次的属性。