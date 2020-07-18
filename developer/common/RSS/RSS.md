来自w3school.com.cn

一个简单的RSS文档

```
<?xml version="1.0" encoding="ISO-8859-1" ?>
<rss version="2.0">

<channel>
    <title>W3School Home Page</title>
    <link>http://www.w3school.com.cn</link>
    <description>Free web building tutorials</description>
    <item>
        <title>RSS Tutorial</title>
        <link>http://www.w3school.com.cn/rss</link>
        <description>New RSS tutorial on W3School</description>
    </item>
    <item>
        <title>XML Tutorial</title>
        <link>http://www.w3school.com.cn/xml</link>
        <description>New XML tutorial on W3School</description>
    </item>
</channel>

</rss>
```

<channel> 元素用于描述 RSS feed。

<channel> 元素有三个必需的子元素：

* <title> - 定义频道的标题。（比如 w3school 首页）
* <link> - 定义到达频道的超链接。（比如 www.w3school.com.cn）
* <description> - 描述此频道（比如免费的网站建设教程）

每个 <channel> 元素可拥有一个或多个 <item> 元素。

每个 <item> 元素可定义 RSS feed 中的一篇文章或 "story"。

<item> 元素拥有三个必需的子元素：

* <title> - 定义项目的标题。（比如 RSS 教程）
* <link> - 定义到达项目的超链接。（比如 http://www.w3school.com.cn/rss）
* <description> - 描述此项目（比如 w3school 的 RSS 教程）

还存在若干个可选的 <channel> 的子元素:

* <category> 子元素使 RSS 聚合器基于类别对网站进行分组成为可能。
* <copyright> 子元素会告知有关版本资料的信息。
* <image> 子元素可在聚合器提供某个 feed 时显示一幅图像。
    <image> 有三个必需的子元素：
    - <url> - 定义引用图像的 URL
    - <title> - 定义图像无法被显示时显示的文本
    - <link> - 定义到达提供此频道的网站的超链接
* <language> 元素使 RSS 聚合器基于语言来对网站进行分组成为可能。

RSS <channel> 参考手册

----|-----
: 元素 : | :	描述 :
<category> | 可选的。为 feed 定义所属的一个或多个种类。
<cloud> | 可选的。注册进程，以获得 feed 更新的立即通知。
<copyright> | 可选。告知版权资料。
<description> | 必需的。描述频道。
<docs> | 可选的。规定指向当前 RSS 文件所用格式说明的 URL。
<generator> | 可选的。指定用于生成 feed 的程序。
<image> | 可选的。在聚合器呈现某个 feed 时，显示一个图像。
<language> | 可选的。规定编写 feed 所用的语言。
<lastBuildDate> | 可选的。定义 feed 内容的最后修改日期。
<link> | 必需的。定义指向频道的超链接。
<managingEditor> | 可选的。定义 feed 内容编辑的电子邮件地址。
<pubDate> | 可选的。为 feed 的内容定义最后发布日期。
<rating> | 可选的。feed 的 PICS 级别。
<skipDays> | 可选的。规定忽略 feed 更新的天。
<skipHours> | 可选的。规定忽略 feed 更新的小时。
<textInput> | 可选的。规定应当与 feed 一同显示的文本输入域。
<title> | 必需的。定义频道的标题。
<ttl> | 可选的。指定从 feed 源更新此 feed 之前，feed 可被缓存的分钟数。
<webMaster> | 可选的。定义此 feed 的 web 管理员的电子邮件地址。

存在若干个 <item> 的可选的子元素:

<author> 子元素用于规定一个项目的作者的电子邮件地址。为了防止垃圾邮件，一些开发者不会使用这个 <author> 元素。
<comments> 子元素允许把一个项目连接到有关此项目的注释。
<enclosure> 子元素允许将一个媒体文件导入一个项中。
<enclosure> 元素有三个必需的属性：
    url - 定义指向此媒体文件的 URL
    length - 定义此媒体文件的长度（字节）
    type - 定义媒体文件的类型

RSS <item> 参考手册

---|---
: 元素 : | :	描述 :
<author> | 可选的。规定项目作者的电子邮件地址。
<category> | 可选的。定义项目所属的一个或多个类别。
<comments> | 可选的。允许项目连接到有关此项目的注释（文件）。
<description> | 必需的。描述此项目。
<enclosure> | 可选的。允许将一个媒体文件导入一个项中。
<guid> | 可选的。为项目定义一个唯一的标识符。
<link> | 必需的。定义指向此项目的超链接。
<pubDate> | 可选的。定义此项目的最后发布日期。
<source> | 可选的。为此项目指定一个第三方来源。
<title> | 必需的。定义此项目的标题。

把您的 RSS 发布到 Web 上

现在是时候把您的 RSS 文件上传到网上了。下面是具体的步骤：

1. 为您的 RSS 命名。请注意文件必须有 .xml 的后缀。
2. 验证您的 RSS 文件。（可以在 http://www.feedvalidator.org 找到很好的验证器）。
3. 把 RSS 文件上传到您的 web 服务器上的 web 目录。
4. 把这个小的橙色按钮 [RSS] 或 [XML] 拷贝到您的 web 目录。
5. 在你希望向外界提供 RSS 的页面上放置这个小按钮。然后向这个按钮添加一个指向 RSS 文件的链接。代码应该类似这样：
<a href="www.w3school.com.cn/rss/myfirstrss.xml">
< img src="www.w3school.com.cn/rss/rss.gif" width="36" height="14">
</a>
6. 把你的 RSS feed 提交到 RSS Feed 目录。要注意！feed 的 URL 不是你的页面，而是您的指向您的 feed 的 URL，比如 "http://www.w3school.com.cn/rss/myfirstrss.xml"。 此处提供一些免费的 RSS 聚合服务：
Syndic8: Over 300,000 feeds listed. Register your feed here.
Daypop: Over 50,000 feeds. Register your feed here.
Newsisfree: Over 18,000 feeds. Register your feed here.
7. 在重要的搜索引擎注册您的 feed ：
Yahoo - http://publisher.yahoo.com/promote.php
Google - http://www.google.com/intl/zh-cn/webmasters/addfeed.html
MSN - http://rss.msn.com/publisher.armx
8. 更新您的 feed - 现在您已获得了来自 Google、Yahoo、以及 MSN 的 RSS feed 按钮。请您务必经常更新您的内容，并保持 RSS feed 的长期可用。

自动的 RSS

如果您不想自己去更新 RSS feed，有一些工具和服务可以为您自动地完成工作，比如：
MyRSSCreator - 在 10 分钟之内提供自动的、可靠的 RSS 服务
FeedFire - 提供免费的 RSS feed 创建和分发
对于那些仅需要一个用于个人网站的 RSS feed 的用户来说，一些流行的 blog (Web Log) 管理器可提供内建的 RSS 服务：
Blogger
Radio

RSS 阅读器
有很多不同的 RSS 阅读器。某些以 web services 的形式来工作，而某些则运行于 windows （或 Mac、PDA 或 UNIX）。
这是一些我尝试过并钟爱的阅读器：
NewsGator Online
一个免费的在线 RSS 阅读器。包含 Outlook 同步，通过 Media Center Edition 查看电视内容，以及 blog 和标题的发布。
RssReader
基于 Windows 的免费 RSS 阅读器。支持 RSS versions 0.9x、1.0 以及 2.0 和 Atom 0.1, 0.2 以及 0.3。
FeedDemon
基于 Windows 的 RSS 阅读器。使用很简便，界面很有条理。可以免费下载！
blogbot
一个针对 Outlook 或 Internet Explorer 的 RSS 阅读器插件。针对 Internet Explorer 的简化版是免费的。
提示：Mozilla Firefox 浏览器拥有内建的 RSS 阅读器。在您访问提供 RSS feed 的网站时，会在地址栏看到 Firefox 的 RSS 图标。点击这个图标可查看一个不同 feed 的列表，在此可选择你需要阅读的 feed。
