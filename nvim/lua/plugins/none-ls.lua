return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        require("none-ls.code_actions.eslint"),
        require("none-ls.diagnostics.eslint_d"),

        -- Habilitar Flake8 configurado para usar as regras do projeto
        require("none-ls.diagnostics.flake8").with({
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
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

        -- Python Formatter
        require("none-ls.formatting.ruff").with({
          extra_args = { "extend-select", "E,I,F" },
          -- Para fazer o ruff também pegar as config do projeto
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        require("none-ls.formatting.ruff_format").with({
          -- Respeitar configurações do projeto
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),

        null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
        null_ls.builtins.formatting.prettier.with { filetypes = { 'json', 'yaml', 'markdown', 'typescript', 'javascript' } },
      },
    })

    require('mason-null-ls').setup({
      ensure_installed = {
        'ruff',
        'prettier',
        'shfmt',
      },
      automatic_installation = true,
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
  end,
}

