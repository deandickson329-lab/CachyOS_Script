# !/bin/bash
# Latest Coding Time : 2026/9/18
# 此脚本用于安装 CachyOs 系统后进行常用软件配置和下载

STD_OS_RELEASE_PATH="/etc/os-release"

if [ ! -e "$STD_OS_RELEASE_PATH" ] || [ -d "$STD_OS_RELEASE_PATH" ];
then
	echo -e "[\033[31mERROR\033[0m] 未找到 os-release 文件"
	exit
fi

OS_RELEASE_CHECK=$(head -n1 /etc/os-release)
SYSTEM_NAME=$(echo $OS_RELEASE_CHECK | grep 'CachyOS')

if [ -z "$SYSTEM_NAME" ];
then
	echo -e "[\033[31mERROR\033[0m] 不是 CachyOS 操作系统"
	exit
fi

#==================== 官方仓库设置 ==========================
# 用于自动化检测CPU架构并配置最优化的软件仓库

echo -e "[\033[32mOK\033[0m] 步骤1 -> 开始官方仓库设置"
cd $HOME && mkdir TempDir && cd TempDir
echo -e "[\033[32mOK\033[0m] 成功生成临时文件夹"
curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo 
echo -e "[\033[32mOK\033[0m] 已解压压缩包 准备运行脚本"
sudo ./cachyos-repo.sh
echo -e "[\033[32mOK\033[0m] 官方脚本运行完成 准备清理临时文件夹"
cd $HOME && rm -r TempDir
echo -e "[\033[32mOK\033[0m] 官方仓库设置成功"

#==================== 必要软件检查 ==========================
echo -e "[\033[32mOK[\033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出"


