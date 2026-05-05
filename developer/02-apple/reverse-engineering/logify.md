# logify 

logify 是 theos 的一个组件。

```
logify.pl /path/to/BaseMsgContentViewController.h > /out/path/to/Tweak.xm
```

这个命令会自动把 BaseMsgContentViewController 中的每个方法 hook，添加 NSLog 日志。方便查看方法调用。