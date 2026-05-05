1. 安装 Python3，在新版的 macOS 环境中，Xcode Command Line 中会自带 Python3，而 Python3 中自带 PIP3，不需要再另外安装。

2. 安装 Scrapy（Scrapy 官方建议在 Python 的虚拟环境中安装 Scrapy）

```SHELL
pip3 install scrapy
```

3. 创建 Scrapy 项目：

```SHELL
scrapy startproject tutorial
```

这个命令会创建一个名为“tutorial”的 Scrapy 项目文件夹，文件夹中会包含一些模版文件。

4. 创建爬虫

```SHELL
scrapy genspider quotes https://quotes.toscrape.com/page/1
```

这就会在项目的 spiders 文件夹中创建 quotes.py 文件

5. 编辑 quotes.py 文件，设定爬虫的规则

```Python
from pathlib import Path

import scrapy

class QuotesSpider(scrapy.Spider):
    name = "quotes"

    def start_requests(self):
        urls = [
            "https://quotes.toscrape.com/page/1/",
            "https://quotes.toscrape.com/page/2/",
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f"quotes-{page}.html"
        Path(filename).write_bytes(response.body)
        self.log(f"Saved file {filename}")
```

这就是一个简单的爬虫类的代码了，Scrapy 爬虫类需要继承 scrapy.Spider 父类，实现两个方法，一个是 start_requests，另一个是 parse。其中

start_requests 方法返回一个 Request 数组，这个数组就是爬虫运行时要执行的请求列表，比如上面的例子中，如果页数不是只有1和2，而是从 1 到 100，那把 100 个 url 都列出来就非常麻烦，就可以在 start_requests 方法中写一个 for 循环来生成 100 个请求；而如果像这个例子中这样，只有两个固定的 url，并且也不需要对 url 做特殊处理的话，可以不实现 start_requests 方法，只定义一个 start_urls 类属性也是一样的效果，如下：

```Python
from pathlib import Path

import scrapy

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        "https://quotes.toscrape.com/page/1/",
        "https://quotes.toscrape.com/page/2/",
    ]

    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f"quotes-{page}.html"
        Path(filename).write_bytes(response.body)
```

parse 方法则是必须要实现的方法，这个方法中要写爬虫在抓取到一个网页后应该做什么处理，比如读取网页里的哪些数据，在上面的例子中，parse 方法是直接把获取到的网页保存到本地了，如果在爬取音乐、视频等不需要解析的文件时就可以用到这种直接保存的逻辑了。

6. 运行爬虫

```SHELL
scrapy crawl quotes
```

运行爬虫后，可以在项目目录下看到两个下载下的文件。
