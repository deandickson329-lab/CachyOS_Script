# !/bin/bash
# Latest Coding Time : 2026/9/18
# 此脚本用于安装 CachyOs 系统后进行基本配置优化
set -e

#==================== 检查系统信息 ====================
# 检查 /etc/os-release 文件并读取系统信息

STD_OS_RELEASE_PATH="/etc/os-release"

if [ ! -e "$STD_OS_RELEASE_PATH" ] || [ -d "$STD_OS_RELEASE_PATH" ];
then
	printf "[\033[31mERROR\033[0m] 未找到 os-release 文件\n"
	exit 0
fi

OS_RELEASE_CHECK=$(head -n1 /etc/os-release)
SYSTEM_NAME=$(echo $OS_RELEASE_CHECK | grep 'CachyOS')

if [ -z "$SYSTEM_NAME" ];
then
	printf "[\033[31mERROR\033[0m] 不是 CachyOS 操作系统\n"
	exit 0
fi

#==================== 官方仓库设置 ==========================
# 用于自动化检测CPU架构并配置最优化的软件仓库

printf "[\033[36mSTEP\033[0m] 设置CachyOs-Repo仓库[y/n] =>" && read -p "" OFFICIAL_REPOSITORY_CHOICE

if [ "$OFFICIAL_REPOSITORY_CHOICE" = "y" ] || [ "$OFFICIAL_REPOSITORY_CHOICE" = "" ];
then
	printf "[\033[32mOK\033[0m] 设置官方仓库\n"
	
	mkdir "$HOME/TempDir" && cd "$HOME/TempDir"
	printf "[\033[32mOK\033[0m] 成功生成临时文件夹\n"
	
	curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz ||
		{
			printf "[\033[31m仓库压缩包下载失败"
			exit 1
		}
	tar xvf cachyos-repo.tar.xz && cd cachyos-repo 
	printf "[\033[32mOK\033[0m] 已解压压缩包 准备运行脚本\n"
	
	sudo ./cachyos-repo.sh ||
		{
			rm -r "$HOME/TempDir"
		}
	printf "[\033[32mOK\033[0m] 官方脚本运行完成 准备清理临时文件夹\n"
	
	cd $HOME && rm -r "TempDir"
	printf "[\033[32mOK\033[0m] 官方仓库设置成功\n"
else
	printf "[\033[32mOK\033[0m] 跳过执行官方仓库设置\n"
fi

#==================== 去除启动报错 ==========================
# 消除开关机提示 Failed to start Virtual Console Setup 避免影响启动速度


printf "[\033[36mSTEP\033[0m] 去除启动报错（Failed to stat Virtual Console Setup）[y/n] =>" && read -p "" START_ERROR_CHOICE
if [ "$START_ERROR_CHOICE" = "y" ] || [ "$START_ERROR_CHOICE" = "" ];
then
	sudo sed -i -E 's/KEYMAP=.*/KEYMAP=us/g' /etc/vconsole.conf
	printf "[\033[32mOK\033[0m] 修改 /etc/vconsole.conf 文件完成\n"
	limine-update

else
	printf "[\033[32mOK\033[0m] 跳过执行去除启动报错"
fi
