查看.a库文件所包含的架构库命令:
lipo -info XXXXX.a

接下来就是从fat文件里面分离出各个架构的库
lipo -thin arm64 libPLPlayerKit.a -output arm64.a

查看.a所包含的.o文件命令:
ar -t XXXXX-armv7.a

解包命令如:
ar -x arm64.a

目录下所有.o文件(用*.o)打包成.a文件,命令:
ar -r *.o libxxx.a

lipo -create armv7.a armv7s.a i386.a x86_64.a arm64.a  -output libPLPlayerKit.a

从每个架构的.a文件中删除与其他sdk引起冲突的.o文件比如本例的ffmpeg
删除.o文件的命令:ar -d -sv XXXXX-armv7.a XXXX.o
