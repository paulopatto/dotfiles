return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")
  end,

  vim.keymap.set(
    "n",
    "<leader>wt",
    "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
    silent
  ),
}
