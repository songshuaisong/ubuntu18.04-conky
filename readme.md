<!--
 * @FilePath    : readme.md
 * @Description : 说明文件
 * @Author      : Songshuai
 * @Date        : 2024-12-18 15:45:59
 * @Copyright (c) 2024 by Songshuai(Songshuai223@gmail.com), All Rights Reserved.
 *
 * @History record
 *  version     date      auther     changes
 *  V0.1.0  2024-12-18  Songshuai    Create
-->

一个ubuntu环境下的桌面美化工具，已经调试完成。

# 1. 准备工作

首先下载并安装conky，使用如下指令：
```bash
$ sudo apt install conky-all -y
```
conky组件要正常运行一般还需要安装lua和curl，可以根据如下指令：

```bash
$ sudo apt install curl lua5.4 -y
```

注意：本人使用的源中并没有找到 lua5.4的安装包，安装的是lua5.3，可以在输入上述指令的时候通过tab键来查看当前存在的版本即可。

# 2. 主题下载

当前目录下已经存在了下载并且修改完成的主题包，如果需要的话可以去下载新的主题包并且进行设置。

下载地址：https://www.pling.com/browse?cat=124&ord=latest

# 3. 主题安装

首先需要在.config目录下新建目录，具体操作步骤如下：

```bash
$ cd ~/.config
$ mkdir conky
```

如果要使用当前包含的主题包，那么将 目录 Shelyak-Dark 复制到新建的目录中，使用指令：

```bash
$ cp ShelyakDark ~/.config/conky -a
```
# 4. 启动软件

可以在任何位置下面执行指令启动：
```bash
$ sh ~/.config/conky/Shelyak-Dark/start.sh
```

或者在主题所在目录下进行启动：
```bash
$ sh start.sh
```

# 5. 设置自启动

这个也很简单的，查看当前目录下是否存在myconky.desktop文件，并且是否具有可执行权限，通过指令查看：
```bash
$ ll myconky.desktop
```
如果存在并且为绿色，则说明文件状态正常且有可执行权限，如果为其他颜色或者不存在，那么具有问题，需要进行处理。
首先新增名称为myconky.desktop的文件。
```bash
$ vi myconky.desktop
```
然后将下面的内容添加到文件中
```
[Desktop Entry]
Name=Startup Script
Exec=~/.config/conky/Shelyak-Dark/start.sh
Terminal=false
Type=Application
Categories=Utility;Application;
StartupNotify=true
```
保存退出即可。

可通过如下指令赋予可执行权限：
```bash
$ chmod u+x myconky.desktop
```

最后将 myconky.desktop 文件放到自启动目录中，使用指令：

```bash
$ sudo cp myconky.desktop /etc/xdg/autostart
```

# 参考来源

本文还没有产生之前使用的参考文档：

https://blog.csdn.net/weixin_43268374/article/details/135755979

