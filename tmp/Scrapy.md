1. 创建一个 Scrapy 项目：

```SHELL
scrapy startproject tutorial
```

这会在当前路径下创建项目文件夹，生成默认的项目文件。

2. 创建爬虫

```SHELL
scrapy genspider quotes https://quotes.toscrape.com/page/1
```

这就会在项目的 spiders 文件夹中创建 quotes.py 文件

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

3. 运行

```SHELL
scrapy crawl quotes
```

4. 除了像上面定义 start_requests() 方法返回 Request 对象数组外，还可以仅定义一个 start_urls 类属性，这样默认的 start_requests() 方法就会使用这个值为你的爬虫初始化请求。

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

## 获取数据

最好的学习如何使用 Scrapy 获取数据的方法是尝试使用 Scrapy shell 选择器：

```SHELL
scrapy shell 'https://quotes.toscrape.com/page/1/'
```

> 记住在命令行中运行 Scrapy shell 时应总是把 url 用引号包起来，否则当 url 中包含参数时（例如`&`符号）时不能正常工作。

在 Windows 上，这里用双引号。

```DOS
scrapy shell "https://quotes.toscrape.com/page/1/"
```

通过 shell，尝试在响应中使用 CSS 选择元素。

```SHELL
>>> response.css("title")
[<Selector query='descendant-or-self::title' data='<title>Quotes to Scrape</title>'>]
```
