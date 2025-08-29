return {
	"voldikss/vim-floaterm",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	config = function()
		-- Você pode adicionar configurações aqui, se necessário.
		-- Por exemplo, para definir opções globais:
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floaterm_position = "center"
		vim.g.floaterm_auto_close = 1
		vim.g.floaterm_keymap_toggle = "<Leader>t"

		-- Mapeamento de teclado para abrir/fechar o Floaterm
		vim.keymap.set("n", "<Leader>t", ":FloatermToggle<CR>", { desc = "Toggle Floaterm" })
		vim.keymap.set("n", "<Leader>lg", ":FloatermNew --name=LazyGit lazygit<CR>", { desc = "LazyGit" })
		vim.keymap.set("n", "<Leader>ld", ":FloatermNew --name=LazyDocker lazydocker<CR>", { desc = "LazyDocker" })
	end,
}

