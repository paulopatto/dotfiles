return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        require("none-ls.code_actions.eslint"),
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.diagnostics.flake8"),
        require("none-ls.diagnostics.ruff"),
        require("none-ls.formatting.ruff"),
        require("none-ls.formatting.jq"),

        -- General
        null_ls.builtins.completion.spell,

        -- markdown || linter
        null_ls.builtins.diagnostics.alex,

        -- Lua language
        null_ls.builtins.formatting.stylua,

        -- Ruby Stack
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.diagnostics.rubocop,

        -- JavaScript / Typescript Stack
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.prettier,

        -- Python Formatter
        -- links:
        -- - https://www.reddit.com/r/neovim/comments/1069wto/what_python_lsp_and_linter/
        -- - https://www.reddit.com/r/neovim/comments/1b5hc2p/nonels_giving_me_errors_starting_from_today/
        null_ls.builtins.formatting.black.with({
          extra_args = { "--line-length", "89", "--skip-string-normalization" }
        }),
        --[[ null_ls.builtins.formatting.ruff.with({
          extra_args = { "--line-length", "89" }
        }), ]]
        --[[ null_ls.builtins.diagnostics.ruff.with({
          extra_args = { "--select", "E,W,F" }
        }), ]]
        null_ls.builtins.formatting.isort,
      },
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
  end,
}

