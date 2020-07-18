# Archive 相关

Archive是打包应用最重要的一个步骤，也是第一步，在这一步将源文件编译归档到一个名为foo.xcarchive包中。这一步如果出了问题，后续的导出将无法进行，如果export报错了，很可能就是archive出错了。人生也是这样，发现问题的时机并不代表产生问题的时机，知道问题的根源，才能解决问题。嗯，所以下面的问题是在export阶段提示的。

## <Project name> does not contain a single–bundle application or contains multiple products. Please select another archive, or adjust your scheme to create a single–bundle application.

这个问题的可能原因：

* archive中包含了头文件

	如果你的应用连接了一个static library，你的archive中会包含头文件，因为这个static library可能使用了Headers build phase来导出头文件。在Xcode中archive有static library的target时，header build phases不能正确工作。删掉这些phase，在你的library中添加一个Copy Files build phase，用来导出你的头文件。(参考后面引用中的Copying Files While Building a Product)
	
	笔者注：对于使用CocoaPods管理第三方库的项目，在Pods工程中有n个target（一个Pods-YourProjectName和n-1个第三方库的target）每个第三方库对应的target的Build Phases中都有Header build phases，但这并会导致产生这个问题，因为我们的主项目只包含了Pods-YourProjectName这个target对应的static library，而这个target的Build Phases中并没有Header build Phases。

* archive中包含 static libraries 或 frameworks。

	必须设置static libraries或frameworks的"Skip Install"为 YES 来防止static libraries或framework被加到archive中。

注意，如果你的archive中包含了头文件、static libraries或frameworks，这个archive将被认为是一个普通的archive，不能被用于导出应用。

# 引用

## Copying Files While Building a Product

在构建过程中，可以使用copy files build phase来复制文件和任何类型的资源。

步骤：

1. 在工程编辑中，选中一个target。
2. 点击工程编辑器顶部的build phases。
3. 菜单中选择 Editor > Add Build Phase > Add Copy Files Build Phase.
4. 展开工程编辑器中的Build Phases面板下的Copy Files分组。
5. 在Destination弹出菜单和Subpath文本框中指定要把文件复制到哪里。
6. 点击加号按钮来选择要复制的文件，然后点击Add。选中"Copy only when installing"来指定只在产品的安装构建中复制文件。