return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      default = { "avante", "lsp", "path", "snippets", "buffer" },

      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
            provider = "google",
            enable_ghost_text = true,
            -- api_key = vim.fn.expand("$GOOGLE_API_KEY"),
            api_key = vim.fn.expand("$GEMINI_API_KEY"),
            model = "gemini-1.5-flash", -- Using the latest Flash model
          },
        },
        snippets = {
          preset = "luasnip",
        },
      },
    },
    menu = {
      draw = {
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" },
        },
        components = {
          kind_icon = {
            text = function(item)
              local kind = require("lspkind").symbol_map[item.kind] or ""
              return kind .. " "
            end,
            highlight = "CmpItemKind",
          },
          label = {
            text = function(item)
              return item.label
            end,
            highlight = "CmpItemAbbr",
          },
          kind = {
            text = function(item)
              return item.kind
            end,
            highlight = "CmpItemKind",
          },
        },
      },
    },
  },
}
