#!/bin/sh
#============================== 必要软件检查 ==============================
# 检测并安装缺失的软件	
set -e
PACKAGE_INSTALLER(){

	local PACKAGE_BOOT_NAME="$1"      # 软件在终端启动时的名称
	local PACKAGE_DOWNLOAD_NAME="$2"  # 软件在仓库内的下载名称

	if [ "$PACKAGE_BOOT_NAME" = "yay" ] && ! command -v "$PACKAGE_BOOT_NAME" >/dev/null 2>&1;
	then 
		# 静默判断传入函数的首个参数是否为 yay 以及是否下载，否则调用pacman命令启动下载
		printf "\033[31m$PACKAGE_BOOT_NAME 未下载 准备启动下载流程\033[0m\n"
		sudo pacman -S $PACKAGE_DOWNLOAD_NAME || 
			{
				printf "\033[31m$PACKAGE_DOWNLOAD_NAME 下载失败";
				exit 1;
			}
	
	elif [ "$PACKAGE_BOOT_NAME" != "yay" ] && ! command -v "$PACKAGE_BOOT_NAME" >/dev/null 2>&1;
	then
		# 除 yay 外其他软件的下载逻辑
		printf "\033[31m$PACKAGE_BOOT_NAME 未下载 准备启动下载流程\033[0m\n"
		yay -S $PACKAGE_DOWNLOAD_NAME ||
			{ 
				printf "\033[31m$PACKAGE_DOWNLOAD_NAME 下载失败";
				exit 1;
			}

	else 
		printf "\033[32m$PACKAGE_BOOT_NAME 已下载 跳过下载执行流程\033[0m\n"
	fi

}




COMPLETE_SOFTWARE_INSTALL(){
	#SIMPLE_SOFTWARE_INSTALL
#============================= 输入法相关设置 =============================
	
	# 下载 gtk qt 兼容组件 管理工具 中州韵以及雾凇输入法
	#yay -S fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-rime rime-ice-git
	printf "[\033[32mOK\033[0m] 下载 fcitx5-gtk等兼容组件、中州韵输入法及组件\n"

	# 将中州韵设置为默认输入法
	# touch $HOME/.local/share/fcitx5/rime/default.custom.yaml
	# echo -e "patch:\n\t__include: rime_ice_suggestion:/" > $HOME/.local/share/fcitx5/rime/default.custom.yaml
	# printf "[\033[32mOK\033[0m] 将输入法兼容选项写入用户环境变量中\n"

	# 修改输入法设置中临时切换输入法选项为空 因为使用时会产生某些BUG 执行完成后仍需手动启动
	#sed -i '\|\[Hotkey/AltTriggerKeys\]|{n;s/.*/AltTriggerKeys=/}' $HOME/.config/fcitx5/config
	#sed -i 's|\[Hotkey/AltTriggerKeys\]|# [Hotkey/AltTriggerKeys]|g' $HOME/.config/fcitx5/config
	printf "[\033[32mOK\033[0m] 修改 临时切换输入法 选项为空\n"

	# 创建用户环境变量environment.d文件夹并在ime.conf文件中写入配置
	#mkdir -p $HOME/.config/environment.d
	#touch $HOME/.config/environment.d/ime.conf
	#echo -e "XMODIFIERS=@im=fcitx\nQT_IM_MODULES=\"wayland;fcitx\"\nQT_IM_MODULE=fcitx\nSDL_IM_MODULE=fcitx" > $HOME/.config/environment.d/ime.conf
	printf "[\033[32mOK\033[0m] 将输入法兼容选项写入用户环境变量中\n"

#============================== GIT相关设置 ==============================
	printf "[\033[32mOK\033[0m] 设置git名称与邮箱\n"
	#git config --global user.name "zerones"
	#git config --global user.email 2947046703@qq.com
}
	
printf "[\033[32mOK\033[0m] 开始安装必要软件\n"
COMPLETE_SOFTWARE_INSTALL
printf "[\033[32mOK\033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出\n"


