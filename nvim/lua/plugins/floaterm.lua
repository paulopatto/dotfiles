return {
  "voldikss/vim-floaterm",
  lazy = false,
  config = function()
    -- Você pode adicionar configurações aqui, se necessário.
    -- Por exemplo, para definir opções globais:
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = "center"
    vim.g.floaterm_auto_close = 1

    -- Mapeamento de teclado para abrir/fechar o Floaterm
    vim.keymap.set("n", "<Leader>nt", ":FloatermToggle<CR>", { desc = "Toggle Floaterm" })
    vim.keymap.set("n", "<Leader>tt", ":FloatermToggle<CR>", { desc = "Toggle Floaterm" })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- Se o plugin tiver dependências
  },
}

