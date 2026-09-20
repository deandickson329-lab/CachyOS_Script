#==================== 必要软件检查 ==========================
# 检测并安装缺失的软件

echo -e "[\033[32mOK\033[0m] 步骤2 -> 开始必要软件清单检查"

if [ -z $(command -v yay) ];
then
	echo "下载 yay 工具"
	sudo pacman -S yay
fi

if [ -z $(command -v fcitx5) ];
then 
	echo "下载 fcitx5 框架、中州韵输入法及组件"
	sudo pacman -S fcitx5-im
	yay -S fcitx5-rime rime-ice-git

	# 将中州韵设置为默认输入法
	# touch $HOME/.local/share/fcitx5/rime/default.custom.yaml
	# echo -e "patch:\n\t__include: rime_ice_suggestion:/" > $HOME/.local/share/fcitx5/rime/default.custom.yaml
	
	echo "将配置写入用户空间环境变量"
	mkdir -p $HOME/.config/environment.d
	touch $HOME/.config/environment.d/ime.conf
	echo -e "XMODIFIERS=@im=fcitx\nQT_IM_MODULES=\"wayland;fcitx\"\nQT_IM_MODULE=fcitx\nSDL_IM_MODULE=fcitx" > $HOME/.config/environment.d/ime.conf

fi

if [ -z $(command -v git) ];
then
	echo "下载 git 工具并初始化配置"
	sudo pacman -S git

	git config --global user.name "zerones"
	git config --global user.email 2947046703@qq.com
fi

echo -e "[\033[32mOK[\033[0m] 检查完成，即将运行滚动更新命令，命令完成后脚本会退出"


