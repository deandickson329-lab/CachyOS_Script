require("blink.cmp").setup({

    -- keymap 按键映射
	-- 'default' （推荐选项）使用与内置补全相似的按键映射 (C-y 接受)
	-- 'super-tab' 使用类似VSCode类似的按键映射 (tab接受)
	-- 'enter' 使用回车接受
	-- 'none' 不使用映射
	--
	-- 所有预设都包含以下映射:
	-- C-space: 打开菜单或菜单中打开文档
	-- C-n/C-p or Up/Down: 选择下/上一个候选项
	-- C-e: 隐藏菜单
	-- C-k: 切换签名帮助(若 signature.enabled = true)
	--
	-- 自定义按键映射请见 :h blink-cmp-config-keymap
	keymap = {

		-- 每个按键可以是一个命令列表或函数列表
		preset = "super-tab",

		-- 选择候选项
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		--["<Tab>"] = { "select_next", "fallback" },
		--["<S-Tab>"] = { "select_prev", "fallback" },

		-- 滚动文档
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		-- 显示/隐藏签名
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},

    -- appearance 外观
	appearance = {

		-- 'mono' 用于 'Nerd Font Mono'
        -- 'normal' 用于 'Nerd Font'
		-- 调整间距以保证图标对齐
		nerd_font_variant = "mono",
	},

    -- sources 补全来源
    -- 默认启用的补全来源列表，定义在这里便于你在配置的其他地方扩展，
    -- 而不必重新定义整份列表（得益于 `opts_extend`）
    -- lsp:语言服务器 path:文件路径 snippets:代码片段 buffer:缓冲区
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

    -- fuzzy 模糊匹配
    -- （默认）Rust 模糊匹配器，抗拼写错误且性能显著更佳
    -- 你也可以通过 `implementation = "lua"` 使用 Lua 实现，
    -- 或在 Rust 模糊匹配器不可用时回退到 Lua 实现，方法是 `implementation = "prefer_rust"`
    -- 更多信息请见模糊匹配相关文档
	fuzzy = { implementation = "prefer_rust_with_warning" },

    -- completion 模糊匹配
	completion = {

		-- 关键词只匹配光标之前的文本
		keyword = { range = "prefix" },
		menu = {

			-- 使用 treesitter 对指定来源的候选项标签文本做高亮
			draw = {
				treesitter = { "lsp" },
			},
		},

		-- 输入由来源定义的触发字符后显示补全
		trigger = { show_on_trigger_character = true },
		documentation = {

			-- 自动显示文档
			auto_show = true,
		},
	},

	-- 签名帮助
	signature = { enabled = true },
})
