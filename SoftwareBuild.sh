#!/bin/zsh
set -e

#==================== 通用下载模块 ==========================
PACKAGE_INSTALLER()
{
	local PACKAGE_NAME="$1"

	if [ "$PACKAGE_NAME" = "yay" ] && ! pacman -Q "$PACKAGE_NAME" >/dev/null 2>&1;
	then 
		# 静默判断传入函数的首个参数是否为 yay 以及是否下载，否则调用pacman命令启动下载
		printf "[\033[31mFAIL\033[0m] $PACKAGE_NAME 未下载 准备启动下载流程\n"
		# sudo pacman -Sy $PACKAGE_NAME 非交互环境下自动安装
		sudo pacman -S $PACKAGE_NAME ||
			{
				printf "[\033[31mFAIL\033[0m] $PACKAGE_NAME 下载失败";
				exit 1;
			}
	
	elif [ "$PACKAGE_NAME" != "yay" ] && ! pacman -Q "$PACKAGE_NAME" >/dev/null 2>&1;
	then
		# 除 yay 外其他软件的下载逻辑
		printf "[\033[31mFAIL\033[0m] $PACKAGE_NAME 未下载 准备启动下载流程\n"
		# yay --noconfirm -S $PACKAGE_NAME 非交互环境下自动安装
		yay -S $PACKAGE_NAME ||
			{ 
				printf "[\033[31mFAIL\033[0m] $PACKAGE_NAME 下载失败";
				exit 1;
			}

	else 
		printf "[\033[32m OK \033[0m] $PACKAGE_NAME 已下载 跳过下载执行流程\n"
	fi

}




#==================== 输入法相关设置 ==========================
FCITX5_CONFIG_SET()
{
    CHOICE=""

	# 下载 gtk qt 兼容组件 管理工具 中州韵以及雾凇输入法
	printf "[\033[36mSTEP\033[0m] 检测fcitx5兼容组件以及雾凇输入法、组件\n"
	PACKAGE_INSTALLER fcitx5-gtk
	PACKAGE_INSTALLER fcitx5-qt
	PACKAGE_INSTALLER fcitx5-configtool
	PACKAGE_INSTALLER fcitx5-rime
	PACKAGE_INSTALLER rime-ice-git
	printf "[\033[32m OK \033[0m] fcitx5-gtk兼容组件以及雾凇输入法、组件下载完成\n"

	# 将中州韵设置为默认输入法
    printf "[\033[36mSTEP\033[0m] 是否将雾凇输入法设置为默认输入法[y/n] =>" && read -p "" CHOICE
    if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "" ];
    then
        touch $HOME/.local/share/fcitx5/rime/default.custom.yaml
        echo -e "patch:\n\t__include: rime_ice_suggestion:/" > $HOME/.local/share/fcitx5/rime/default.custom.yaml
        printf "[\033[32m OK \033[0m] 将输入法兼容选项写入用户环境变量中\n"

    else
        printf "[\033[32m OK \033[0m] 跳过执行流程\n"
    fi

    CHOICE=""

	# 修改输入法设置中临时切换输入法选项为空 因为使用时会产生某些BUG 执行完成后仍需手动重启
    printf "[\033[36mSTEP\033[0m] 是否设置临时输入法的快捷键为空[y/n] =>" && read -p "" CHOICE
	if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "" ];
	then
        touch $HOME/.config/fcitx5/config
		sed -i '\|\[Hotkey/AltTriggerKeys\]|{n;s/.*/AltTriggerKeys=/}' $HOME/.config/fcitx5/config
		sed -i 's|\[Hotkey/AltTriggerKeys\]|# [Hotkey/AltTriggerKeys]|g' $HOME/.config/fcitx5/config
		printf "[\033[32m OK \033[0m] 已修改临时切换输入法选项为空\n"
	else

		printf "[\033[32m OK \033[0m] 跳过执行流程\n"
	fi

    CHOICE=""

	# 创建用户环境变量environment.d文件夹并在ime.conf文件中写入配置
    printf "[\033[36mSTEP\033[0m] 是否将输入法兼容选项写入用户环境变量[y/n] =>" && read -p "" CHOICE
	if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "" ];
    then
        mkdir -p $HOME/.config/environment.d
        touch $HOME/.config/environment.d/ime.conf
        echo -e "XMODIFIERS=@im=fcitx\nQT_IM_MODULES=\"wayland;fcitx\"\nQT_IM_MODULE=fcitx\nSDL_IM_MODULE=fcitx" > $HOME/.config/environment.d/ime.conf
        printf "[\033[32m OK \033[0m] 将输入法兼容选项写入用户环境变量中\n"
    else
        printf "[\033[32m OK \033[0m] 跳过执行流程\n"
    fi

    # 热重启fcitx5
	killall -HUP fcitx5
}	



#==================== ZSH 相关设置 ==========================
ZSH_CONFIG_SET()
{
	# 下载zsh以及相关插件
	PACKAGE_INSTALLER zsh
	PACKAGE_INSTALLER zsh-autosuggestions
	PACKAGE_INSTALLER zsh-history-substring-search
	PACKAGE_INSTALLER zsh-syntax-highlighting

	# 脚本路径
	local SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	# 插件路径
	local PLUGIN_PATH=""
	
	# 向用户目录下的.zshrc写入基本配置
	cat "${SCRIPT_PATH}/config/zsh_config/.zshrc.default" > $HOME/.zshrc
	printf "[\033[32m OK \033[0m] 写入.zshrc基本配置\n"

	for PLUGIN in "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting"
	do
		# 获取下载好的插件路径
		PLUGIN_PATH=$(pacman -Qlq "${PLUGIN}" | grep -E "/${PLUGIN}\.zsh$" | head -n1)

		# 将标记替换为source命令
		sed -i "s|# ${PLUGIN}|source ${PLUGIN_PATH}|" ~/.zshrc
	done

	printf "[\033[32m OK \033[0m] zsh 配置完成\n"

}


NEOVIM_CONFIG_SET()
{
	PACKAGE_INSTALLER neovim
 
    # 脚本路径
	local SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # 创建.config/nvim
    mkdir -p $HOME/.config/nvim

    # 将脚本文件夹下的文件复制到.config/nvim
    cp -r "${SCRIPT_PATH}/config/nvim_config/* $HOME/.config/nvim"
    printf "[\033[32m OK \033[0m] 写入NEOVIM的基本配置\n"
}


printf "[\033[36mSTEP\033[0m] 开始安装必要软件\n"

PACKAGE_INSTALLER yay
PACKAGE_INSTALLER fcitx5
PACKAGE_INSTALLER git


FCITX5_CONFIG_SET
ZSH_CONFIG_SET
NEOVIM_CONFIG_SET

printf "[\033[32m OK \033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出\n"
