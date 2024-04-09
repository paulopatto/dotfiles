return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Availables LSP Servers
				-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
				ensure_installed = {
					--"ansiblels",
					--"arduino_language_server",
					--"bashls",
					--"clangd",
					--"docker_compose_language_service",
					--"dockerls",
					--"golangci_lint_ls", -- Alternative: gopls
					--"intelephense",
					--"jsonls", -- Alternative: biome
					"lua_ls",
					--"markdown_oxide",
					--"ocamllsp",
					"pyright",
					--"ruby_ls", -- Alternative: solargraph
					--"sqlls",
					"tailwindcss",
					"tsserver", -- Alternative: biome for JavaScript, TS, JSON
					--"yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.pyright.setup({})

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			-- Read more: https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- Will open helper pop-up
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
