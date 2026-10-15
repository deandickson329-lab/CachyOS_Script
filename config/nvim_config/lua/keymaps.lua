local opts = {
    noremap = true, -- 非递归映射 避免映射套映射
    silent = true,  -- 执行映射时不显示命令行回显
}


vim.g.mapleader = "\\"


----------------
-- Normal模式 --
-- -------------

vim.keymap.set('n', '<C-h>', '<C-w>h', opts) -- Ctrl + h 向左边窗口移动
vim.keymap.set('n', '<C-j>', '<C-w>j', opts) -- Ctrl + j 向下边窗口移动
vim.keymap.set('n', '<C-k>', '<C-w>k', opts) -- Ctrl + k 向上边窗口移动
vim.keymap.set('n', '<C-l>', '<C-w>l', opts) -- Ctrl + l 向右边窗口移动

------------------
-- 调整窗口大小 --
------------------

vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', opts)             -- Ctrl + Up    增加当前窗口高度两行
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', opts)           -- Ctrl + Down  减少当前窗口高度两行
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)  -- Ctrl + Left  减少当前窗口宽度两行
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts) -- Ctrl + Right 增加当前窗口高度两行

------------------
-- 快捷启动插件 --
------------------

-- 打开/关闭文件树 
vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- 在当前文件位置打开/关闭（会自动定位到当前文件）
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle explorer on current file" })
