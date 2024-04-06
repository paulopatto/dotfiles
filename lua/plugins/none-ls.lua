return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Lua language
				null_ls.builtins.formatting.stylua,

				-- Ruby Stack
				null_ls.builtins.formatting.rubocop,
				null_ls.builtins.diagnostics.rubocop,

        -- JavaScript / Typescript Stack
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d.with ({
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE
        }),


        -- Python
        -- link: https://www.reddit.com/r/neovim/comments/1069wto/what_python_lsp_and_linter/
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.isort.with({ --/flake8
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE
        })
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
