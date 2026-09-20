#============================== 必要软件检查 ==============================
# 检测并安装缺失的软件

SIMPLE_SOFTWARE_INSTALL(){
	
	echo -e "[\033[32mOK\033[0m] 开始下载基本工具"

	if [ -z $(command -v yay) ];
	then
		echo "检测到 yay 工具缺失，正在下载 yay 工具"
		#sudo pacman -S yay
	fi

	for SOFTWARE in fcitx5 git
	do
		if [ ! -z $(command -v $SOFTWARE) ];
		then
			echo -e "正在下载 $SOFTWARE"
			#yay -S $SOFTWARE
		fi
	done
	
	echo -e "[\033[32mOK\033[0m] 基本工具下载完成"
}

COMPLETE_SOFTWARE_INSTALL(){
	#SIMPLE_SOFTWARE_INSTALL
#============================= 输入法相关设置 =============================
	echo -e "[\033[32mOK\033[0m] 下载 fcitx5-gtk等兼容组件、中州韵输入法及组件"
	#yay -S fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-rime rime-ice-git

	# 将中州韵设置为默认输入法
	# touch $HOME/.local/share/fcitx5/rime/default.custom.yaml
	# echo -e "patch:\n\t__include: rime_ice_suggestion:/" > $HOME/.local/share/fcitx5/rime/default.custom.yaml
	
	echo -e "[\033[32mOK\033[0m] 向用户环境变量中写入配置"
	#mkdir -p $HOME/.config/environment.d
	#touch $HOME/.config/environment.d/ime.conf
	#echo -e "XMODIFIERS=@im=fcitx\nQT_IM_MODULES=\"wayland;fcitx\"\nQT_IM_MODULE=fcitx\nSDL_IM_MODULE=fcitx" > $HOME/.config/environment.d/ime.conf

#============================== GIT相关设置 ==============================
	echo -e "[\033[32mOK\033[0m] 设置git名称与邮箱"
	#git config --global user.name "zerones"
	#git config --global user.email 2947046703@qq.com

}

echo -e "[\033[32mOK\033[0m] 开始安装必要软件"

COMPLETE_SOFTWARE_INSTALL




echo -e "[\033[32mOK\033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出"


