# 本地部署千问Agent

https://developer.aliyun.com/article/1374208

安装 Python 环境（miniconda）

从https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/ 找到对应系统的安装脚本，下载并执行。

这个步骤会在本地安装 miniconda，我在 CentOS 8 上安装的，安装后还需要配置一下环境变量。然后执行

conda init

pip install vllm



1、设置Python安装默认源（可选）

pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/

将 pip 的默认软件包源（PyPI）更改为阿里云镜像源，好处就是下载速度更快和链接更稳定，但是要注意的是使用这个命令修改全局配置会影响所有使用 pip 安装软件包的项目。如果只想在特定项目中使用该镜像源，可以在项目的根目录下创建一个名为 .pip 或 pip.ini 的文件，并将相同的配置内容写入其中，这样只会影响该项目。

2、创建虚拟环境

conda create -n qwen-agent python=3.10 -y
conda activate qwen-agent

第一句命令 conda create -n qwen-agent python=3.10 -y 是指使用conda来创建一个名为"qwen-agent"的虚拟环境，并指定要安装的Python版本为3.10。其中，-n qwen-agent 指定了要创建的虚拟环境的名称为"qwen-agent"，python=3.10 指定了要在该环境中安装的Python版本为3.10，-y 则表示在执行过程中不需要确认操作，直接进行安装。

第二句命令 conda activate qwen-agent 是用于激活名为"qwen-agent"的虚拟环境。激活后，系统中将会使用该虚拟环境中安装的Python版本和相关包来执行Python程序。激活后，命令行提示符通常会显示当前已经激活的虚拟环境名称，如"(qwen-agent)"，以示当前环境已经切换为"qwen-agent"。

3、安装pytorch

pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 torchaudio==2.0.1 --index-url https://download.pytorch.org/whl/cu118

这条命令是使用pip安装特定版本的PyTorch、torchvision和torchaudio库，同时指定了运行所需的CUDA版本为cu118，并将下载源设置为PyTorch官方提供的URL。

具体来说，命令中的参数解释如下：

torch==2.0.0+cu118: 这表示要安装的PyTorch版本是2.0.0，并且需要与CUDA版本cu118兼容。PyTorch是一个用于深度学习的开源机器学习库。

torchvision==0.15.1+cu118: 这表示要安装的torchvision版本是0.15.1，并且需要与CUDA版本cu118兼容。torchvision是PyTorch的一个独立软件包，用于对图像和视频数据进行处理。

torchaudio==2.0.1: 这表示要安装的torchaudio版本是2.0.1。torchaudio是一个用于处理音频数据的PyTorch扩展库。

--index-url https://download.pytorch.org/whl/cu118: 这是一个额外的选项，用于指定下载PyTorch和相关库时要使用的镜像源或索引URL。在这里，https://download.pytorch.org/whl/cu118 是PyTorch官方提供的针对CUDA 11.1.1版本的URL地址，它指示pip从该地址下载所需的库文件。

4、安装 flash-attention

git clone -b v1.0.8 https://github.com/Dao-AILab/flash-attention; cd flash-attention
pip uninstall -y ninja && pip install ninja
cd flash-attention && pip install .

5、部署 Qwen 模型服务

安装依赖

git clone https://github.com/QwenLM/Qwen.git; cd Qwen
pip install -r requirements.txt
pip install fastapi uvicorn openai "pydantic>=2.3.0" sse_starlette

启动模型服务，通过 -c 参数指定模型版本

指定 --server-name 0.0.0.0 将允许其他机器访问您的模型服务

指定 --server-name 127.0.0.1 则只允许部署模型的机器自身访问该模型服务

python openai_api.py --server-name 0.0.0.0 --server-port 7905 -c Qwen/Qwen-7B-Chat

目前，支持指定的-c参数为以下模型，按照GPU显存开销从小到大排序：

Qwen/Qwen-7B-Chat-Int4

Qwen/Qwen-7B-Chat

Qwen/Qwen-14B-Chat-Int4

Qwen/Qwen-14B-Chat

对于7B模型，请使用2023年9月25日之后从官方HuggingFace重新拉取的版本，因为代码和模型权重都发生了变化。

6、部署 Qwen-Agent

安装依赖

git clone https://github.com/QwenLM/Qwen-Agent.git
cd Qwen-Agent
pip install -r requirements.txt

启动数据库服务，通过 --model_server 参数指定您在 Step 1 里部署好的模型服务

若 Step 1 的机器 IP 为 123.45.67.89，则可指定 --model_server http://123.45.67.89:7905/v1

若 Step 1 和 Step 2 是同一台机器，则可指定 --model_server http://127.0.0.1:7905/v1

python run_server.py --model_server http://127.0.0.1:7905/v1 --workstation_port 7864

7、浏览器访问Qwen-Agent

打开 http://127.0.0.1:7864/ 来使用工作台（Workstation）的创作模式（Editor模式）和对话模式（Chat模式）。

image.png

8、安装浏览器助手

安装BrowserQwen的Chrome插件（又称Chrome扩展程序）：

打开Chrome浏览器，在浏览器的地址栏中输入 chrome://extensions/ 并按下回车键；

确保右上角的 开发者模式 处于打开状态，之后点击 加载已解压的扩展程序 上传本项目下的 browser_qwen 目录并启用；

单击谷歌浏览器右上角扩展程序图标，将BrowserQwen固定在工具栏。

【注意】：安装Chrome插件后，需要刷新页面，插件才能生效。

当您想让Qwen阅读当前网页的内容时：

请先点击屏幕上的 Add to Qwen's Reading List 按钮，以授权Qwen在后台分析本页面。

再单击浏览器右上角扩展程序栏的Qwen图标，便可以和Qwen交流当前页面的内容了。
