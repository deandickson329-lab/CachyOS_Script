#!/bin/sh
#============================== 必要软件检查 ==============================
# 检测并安装缺失的软件	
set -e
PACKAGE_INSTALLER()
{

	local PACKAGE_NAME="$1"

	if [ "$PACKAGE_NAME" = "yay" ] && ! pacman -Q "$PACKAGE_NAME" >/dev/null 2>&1;
	then 
		# 静默判断传入函数的首个参数是否为 yay 以及是否下载，否则调用pacman命令启动下载
		printf "\033[31m$PACKAGE_NAME 未下载 准备启动下载流程\033[0m\n"
		# sudo pacman -Sy $PACKAGE_NAME 非交互环境下自动安装
		sudo pacman -S $PACKAGE_NAME ||
			{
				printf "\033[31m$PACKAGE_NAME 下载失败";
				exit 1;
			}
	
	elif [ "$PACKAGE_NAME" != "yay" ] && ! pacman -Q "$PACKAGE_NAME" >/dev/null 2>&1;
	then
		# 除 yay 外其他软件的下载逻辑
		printf "\033[31m$PACKAGE_NAME 未下载 准备启动下载流程\033[0m\n"
		# yay --noconfirm -S $PACKAGE_NAME 非交互环境下自动安装
		yay -S $PACKAGE_NAME ||
			{ 
				printf "\033[31m$PACKAGE_NAME 下载失败";
				exit 1;
			}

	else 
		printf "\033[32m$PACKAGE_NAME 已下载 跳过下载执行流程\033[0m\n"
	fi

}




SOFTWARE_CONFIG_SET()
{
#============================= 输入法相关设置 =============================
	
	# 下载 gtk qt 兼容组件 管理工具 中州韵以及雾凇输入法
	PACKAGE_INSTALLER fcitx5-gtk
	PACKAGE_INSTALLER fcitx5-qt
	PACKAGE_INSTALLER fcitx5-configtool
	PACKAGE_INSTALLER fcitx5-rime
	PACKAGE_INSTALLER rime-ice-git
	printf "[\033[32mOK\033[0m] fcitx5-gtk等兼容组件、中州韵输入法及组件 下载完成\n"

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

	#killall -HUP fcitx5

#============================== GIT相关设置 ==============================
	printf "[\033[32mOK\033[0m] 设置git名称与邮箱\n"
	#git config --global user.name "zerones"
	#git config --global user.email 2947046703@qq.com
}
	
printf "[\033[32mOK\033[0m] 开始安装必要软件\n"


PACKAGE_INSTALLER yay
PACKAGE_INSTALLER fcitx5
PACKAGE_INSTALLER git
PACKAGE_INSTALLER clash-verge-rev-bin

SOFTWARE_CONFIG_SET

printf "[\033[32mOK\033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出\n"


