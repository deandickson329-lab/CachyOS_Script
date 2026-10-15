# CachyOS_Script
安装CachyOS系统后用于设置系统参数和下载软件的脚本


## 文件说明

./SystemSet.sh
设置官方系统仓库同时优化软件源

./SoftwareBuild.sh
自动化下载相应软件
设置 FCITX5 输入法为默认输入法、解决BUG、创建用户变量
设置 ZSH 插件与配置（将 ./config/zsh_config/.zshrc.default 中的配置写入 ~/.zshrc 中）

./config/zsh_config/.zsh.default
ZSH 的默认配置
