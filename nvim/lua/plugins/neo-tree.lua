return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup({
      close_if_last_window = true, -- - Close Neo-tree if it is the last window left in the tab
      filesystem = {
        filtered_items = {
          never_show = {
            ".DS_Store",
            ".git",
            "thumbs.db",
          },
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_gitignored = true,
          hide_by_name = {
            "node_modules"
          },
        },
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖",-- this can only be used in the git_status source
          renamed   = "󰁕",-- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    })
    -- NeoTree
    vim.keymap.set('n', '<leader>p', ':Neotree filesystem reveal left<CR>', {})
  end
}

