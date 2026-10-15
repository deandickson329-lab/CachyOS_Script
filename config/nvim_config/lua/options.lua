-- 编辑器选项配置
-- 使用 `:h <option>` 查询某项的含义
vim.opt.clipboard = 'unnamedplus' 			            -- 使用系统剪贴版以直接 Y/P
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- 控制插入模式行为 menu:显示补全菜单 menuone:又一个也显示 noselect:不自动选中第一项 需手动选择
vim.opt.mouse = 'a' 					                -- 所有模式下启用鼠标控制

-- 缩进/Tab配置
vim.opt.tabstop = 4 	 -- 一个TAB为4个空格的宽度
vim.opt.softtabstop = 4  -- 按TAB键插入4个空格
vim.opt.shiftwidth = 4 	 -- 自动缩进时移动4个空格
vim.opt.expandtab = true -- 文件中将TAB键更换为空格（For Python）

-- UI 配置
vim.opt.number = true 	       -- 显示绝对行号
vim.opt.relativenumber = false -- 同步显示相对行号
vim.opt.cursorline = true      -- 高亮光标所在行
vim.opt.splitbelow = true      -- 上下分屏(:split)时新窗口在下方
vim.opt.splitright = true      -- 左右分屏(:vsplit)时新窗口在右侧
-- vim.opt.termguicolors = true  -- 启用24-bit RGB真彩色
vim.opt.showmode = false      -- 不显示 "-- INSERT --" 等模式提示

-- 搜索配置
vim.opt.incsearch = true  -- 边输入边搜索（增量搜索）
vim.opt.hlsearch = false  -- 搜索后不高亮所有匹配项
vim.opt.ignorecase = true -- 默认忽略大小写
vim.opt.smartcase = true  -- 输入含大写时区分大小写
