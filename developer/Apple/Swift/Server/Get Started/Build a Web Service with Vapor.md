## 安装 Vapor

```bash
brew install vapor
```

其他系统则参考[Vapor 文档](https://docs.vapor.codes/install/linux/#install-toolbox)。

## 创建项目

```bash
vapor new HelloVapor
```

这会下载一个模板，并向你提出一系列问题，以创建一个包含所有入门所需内容的简单项目。本指南将创建一个简单的REST API，你可以通过它发送和接收JSON数据。因此，对所有其他问题都回答“否”即可。你会看到项目创建成功

Vapor的模板已经为你设置了许多文件和函数。`configure.swift`包含配置应用程序的代码，`routes.swift`包含路由处理程序代码。

## 创建路由

首先，打开routes.swift，并在app.get("hello") { ... }下方声明一个新路由，以便向访问你网站的任何人问好：

```swift
app.get("hello", ":name") { req async throws -> String in
    let name = try req.parameters.require("name")
    return "Hello, \(name.capitalized)!"
}
```

1. 声明一个新的路由处理器，注册为对`/hello/<NAME>`的GET请求。`:`在 Vapor 中表示动态路径参数，它会匹配任何值，并允许你在路由处理器中获取该值。`app.get(...)`将闭包作为最终参数，该闭包可以是异步的，且必须返回一个`Response`或符合`ResponseEncodable`协议的内容，例如`String`。

2. 从参数中获取名称。默认情况下，这会返回一个String。如果你想提取其他类型，例如Int或通用唯一标识符(UUID)，可以编写`req.parameters.require("id", as: UUID.self)`，Vapor 会尝试将其转换为该类型，如果无法转换，则会自动抛出错误。如果路由未使用正确的参数名称注册，这也会抛出错误。

3. 返回 Response，在这种情况下是一个 String。请注意，你不需要设置状态码、响应体或任何头信息。Vapor 会为你处理所有这些，同时允许你在需要时控制返回的 Response。

保存文件并构建运行应用程序：

```bash
$ swift run
Building for debugging...
...
Build complete! (59.87s)
[ NOTICE ] Server starting on http://127.0.0.1:8080
```

```bash
$ curl http://localhost:8080/hello/tim
Hello, Tim!
```

## 返回 JSON

Vapor 在底层使用 Codable 来简化 JSON 的发送和接收，它通过一个名为 Content 的包装协议来添加一些额外功能。在 routes.swift 的底部创建一个新类型：

```swift
struct UserResponse: Content {
    let message: String
}
```

创建一个新路由，以返回此JSON：

```swift
app.get("json", ":name") { req async throws -> UserResponse in
    let name = try req.parameters.require("name")
    let message = "Hello, \(name.capitalized)!"
    return UserResponse(message: message)
}
```

保存、构建并重新运行应用程序，然后向`http://localhost:8080/json/tim`发送一个GET请求：

```bash
$ curl http://localhost:8080/json/tim
{"message":"Hello, Tim!"}
```

## 处理 JSON

在 routes.swift 的底部，创建一个新类型来为你要发送到服务器应用的JSON建模：

```swift
struct UserInfo: Content {
    let name: String
    let age: Int
}
```

创建一个新路由来处理带有以下主体的POST请求：

```swift
app.post("user-info") { req async throws -> UserResponse in
    let userInfo = try req.content.decode(UserInfo.self)
    let message = "Hello, \(userInfo.name.capitalized)! You are \(userInfo.age) years old."
    return UserResponse(message: message)
}
```

```bash
$ curl http://localhost:8080/user-info -X POST -d '{"name": "Tim", "age": 99}' -H "Content-Type: application/json"
{"message":"Hello, Tim! You are 99 years old."}
```

恭喜！你已经用Swift搭建了自己的第一个Web服务器！
