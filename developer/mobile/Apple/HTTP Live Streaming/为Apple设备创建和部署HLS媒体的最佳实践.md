#  TN2224为Apple设备创建和部署HLS媒体的最佳实践

[Apple文档原文链接](https://developer.apple.com/library/content/technotes/tn2224/_index.html#//apple_ref/doc/uid/DTS40009745-CH1-DEPLOYYOURMEDIA)

这篇技术说明讨论一些为 Apple 设备创建和部署 HTTP Live Streaming 媒体的最佳实践。

## 介绍



### 开始

### 工作流程

## Decide on Your Variants

### Encoding Hardware, Budget Constraints

### Ability to Switch

### Device Capabilities

### Network Capabilities

### Bit rate recommendations

### Special considerations for cellular

## Encode your Variants

### Recommended Encoding Settings for HTTP Live Streaming Media

## Segment your Media

### Media Stream Segmenter Tool

### Media File Segmenter Tool

### Creating an audio only stream

### Transport Stream Structural Overhead

### Use at least one IDR-frame per segment(prefeerably at the start)

### Use 6 second Target Durations

## Create Master Playlist

### Variant (Master) Playlist Create Tool

## Deploy Your Media

### HTML5 video element

### Web Server Configuration

### Serve playlists using gzip

### Keep Track of your Performance

### Content protection

## Validate Your Media

### Media Stream Validator Tool

### HLS Report Tool

## References

## Document Revision History
