return {
  {
    "b3nj5m1n/kommentary",
    config = function ()
      require('kommentary.config').configure_language('default', {
        single_line_comment_string = 'auto',
        multi_line_comment_strings = 'auto',
        hook_function = function()
          require('ts_context_commentstring').update_commentstring()
        end,
      })
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function ()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      require('todo-comments').setup({
        gui_style = {
          fg = "NONE", -- The gui style to use for the fg highlight group.
          bg = "BOLD", -- The gui style to use for the bg highlight group.
        },

        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end
 },
}
