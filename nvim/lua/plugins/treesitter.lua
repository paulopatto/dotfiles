-- Treesitter configs
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter_configs = require("nvim-treesitter.configs")
		treesitter_configs.setup({
			highlight = {
				enable = true,
				additiona_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true },
			ensure_installed = {
				"c",
				"html",
				"java",
				"javascript",
				"kotlin",
				"lua",
				"python",
				"ruby",
				"typescript",
			},
			auto_install = true,
		})
	end,
}

