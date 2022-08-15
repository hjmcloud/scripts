#!/bin/sh
###############################################################################
# Install Golang 安装Golang,仅限linux系统.                                      #
# Author: LiDong                                                              #
# Email: cnlidong@live.cn                                                     #
# Date: 2022-08-15                                                            #
###############################################################################
# 出错退出
set -e
# 获取参数设为版本号
version=$1
# 判断版本号参数是否为空
if [ -z "$version" ]; then
    echo "请输入版本号"
    exit 1
fi
echo "version: $version"
# 判断当前用户是否为root，不是则退出
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install, you can use the command: sudo -i to login root user"
    echo "Error: 请使用root用户运行,你可以使用命令: sudo -i 切换到root用户."

    exit 1
fi
# 安装Golang
echo "Install Golang..."
# 获取当前操作系统
OS=$(uname)
# 判断是否是Linux系统,如果不是则退出
if [ $OS != "Linux" ]; then
    echo "Not Linux system, exit..."
    exit
fi
# 获取CPU类型
CPU=$(uname -m)
# 转换CPU类型为go env arch格式
if [ $CPU = "x86_64" ]; then
    CPU="amd64"
elif [ $CPU = "i686" ]; then
    CPU="386"
elif [ $CPU = "armv6l" ]; then
    CPU="armv6l"
elif [ $CPU = "aarch64" ]; then
    CPU="arm64"
else
    echo "Not support CPU, exit..."
    exit
fi
# 安装Golang
curl -L https://go.dev/dl/go${VERSION}.$OS-$ARCH.tar.gz -o /tmp/go${VERSION}.$OS-$ARCH.tar.gz
tar -C /usr/local -xzf /tmp/go${VERSION}.$OS-$ARCH.tar.gz
# 删除临时文件
rm -f /tmp/go${VERSION}.$OS-$ARCH.tar.gz
# 配置环境变量
echo "export PATH=$PATH:/usr/local/go/bin" >>/etc/profile
echo "Please reboot or run this command: export PATH=\$PATH:/usr/local/go/bin"
