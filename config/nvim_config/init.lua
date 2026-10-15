-- .
-- ├── init.lua             -- 配置主文件 入口文件
-- ├── lsp                  -- 语言服务器（暂无）
-- │   └── ty.lua           -- Python lsp服务器
-- ├── lua                  -- 子项配置文件夹
-- │   ├── keymaps.lua      -- 配置按键映射
-- │   ├── lsp.lua          -- 配置LSP
-- │   └── options.lua      -- 配置Neovim选项
-- ├── nvim-pack-lock.json  -- 原生插件管理器LOCK配置 
-- └── plugin               -- 插件文件夹
--     ├── blink.cmp.lua    -- 补全插件 
--     ├── nvim-tree.lua    -- 文件浏览器
--     ├── nvim-tree.lua    -- 侧边文件浏览器
--     └── monokai.nvim.lua -- monokai主题


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/tanvirtin/monokai.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/akinsho/bufferline.nvim"},
})


require('options')
require('keymaps')
-- require('lsp')
