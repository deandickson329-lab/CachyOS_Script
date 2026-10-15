-- ~/.config/nvim/lua/plugins/bufferline.lua

vim.opt.termguicolors = true

require('bufferline').setup({
  options = 
  {
      mode = 'buffers',
      numbers = 'none',
      diagnostics = 'nvim_lsp',
      separator_style = 'slant',
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      color_icons = true,

      offsets = 
      {
          {
              filetype = "NvimTree",
              text = "文件管理器",
              text_align = "center",
              highlight = "Directory",
              separator = true,
          },
      },
  },
})
