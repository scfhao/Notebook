# xcodebuild 命令笔记

## Usage

使用前，需要先切换到工程目录（包含projectname.xcodeproj包的目录）。如果当前目录下有多个工程文件，需要使用`-project`参数指定要编译哪个工程。默认情况下，xcodebuild 会使用默认的 build configuration 编译工程中第一个 target。

要编译 Xcode workspace，必须同时指定要编译的`-workspace`和`-scheme`选项。scheme 参数会控制编译哪个 target 及如何编译，不过你可以对 xcodebuild 传入其他参数来覆盖 scheme 中的一些参数。

还有一些参数用来展示安装的Xcode的版本或当前路径下的project或workspace的信息，这些参数不会开始一次编译。包括`-version`、`-showsdks`和`-usage`。

要覆盖Xcode工程中的设置时，可以先通过`showBuildSettings`命令查看如何设置。

$ xcodebuild -showBuildSettings -project TestCI.xcodeproj

## 导出归档


## 示例

* xcodebuild clean install

	清空 build 目录，然后编译和安装 Xcode 工程中的第一个 target。

* xcodebuild -target MyTarget OBJROOT=/Build/MyProj/Obj.root SYMROOT=/Build/MyProj/Sym.root
* xcodebuild -sdk macosx10.6
* xcodebuild -workspace MyWorkspace.xcworkspace -scheme MyScheme
* xcodebuild -workspace MyWorkspace.xcworkspace -scheme MyScheme archive

	归档 MyWorkspace.xcworkspace Xcode工程中的 MyScheme scheme。

* xcodebuild -workspace MyWorkspace.xcworkspace -scheme MyScheme -destination 'platform=OS X,arch=x86_64' test
* xcodebuild -workspace MyWorkspace.xcworkspace -scheme MyScheme -destination 'platform=iOS Simulator,name=iPhone' -destination 'platform=iOS,name=My iPad' test
* xcodebuild -workspace MyWorkspace.xcworkspace -scheme MyScheme -destination generic/platform=iOS build
* xcodebuild -exportArchive -exportFormat IPA -archivePath MyMobileApp.xcarchive -exportPath MyMobileApp.ipa -exportProvisioningProfile 'MyMobileApp Destribution Profile'

	将 MyMobileApp.xcarchive 归档为 IPA文件保存到 MyMobileApp.ipa 使用 `MyMobileApp Distribution Profile` 描述文件。

* xcodebuild -exportArchive -exportFormat APP -archivePath MyMacApp.xcarchive -exportPath MyMacApp.pkg -exportSigningIdentity 'Developer ID Application: My Team'

	将 MyMacApp.xcarchive 归档导出为 PKG 文件保存到 MyMacApp.pkg 目录，使用`Developer ID Application: My Team`签名。安装器（installer）身份签名`Developer ID Application: My Team`被隐式用于导出的包的签名。









































