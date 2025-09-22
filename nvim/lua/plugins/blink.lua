---@module "lazy"
---@type LazySpec
return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "yetone/avante.nvim",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "Kaiser-Yang/blink-cmp-avante",
  },
  event = "VeryLazy",
  lazy = true,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },

    -- Suporte experimental de ajuda de assinatura
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },

      menu = {
        border = "rounded",

        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,

        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
          treesitter = { "lsp" },
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
    -- keymap = { preset = "default" },
    --
    -- configuração super-TAB
    -- See also: https://www.reddit.com/r/neovim/comments/1hlnv7x/blinkcmp_i_finally_have_a_configuration_that/?tl=pt-br
    -- TODO: Talvez substituir por https://github.com/ThorstenRhau/neovim/blob/59caa4c42c4f891b211c1f2593e4af89af2bd02b/lua/optional/blink-cmp.lua#L48C5-L50C7
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          return cmp.select_next()
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          return cmp.select_prev()
        end,
        "snippet_backward",
        "fallback",
      },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },

    sources = {

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      default = { "snippets", "avante", "lsp", "path", "buffer" },

      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          score_offset = 1000, -- Boost score to prioritize over other sources
          opts = {
            -- Opções específicas do blink-cmp-avante
            command = {
              get_kind_name = function(_)
                return "AvanteCmd"
              end,
            },
            mention = {
              get_kind_name = function(_)
                return "AvanteMention"
              end,
            },
          },
        },
        --[[ snippets = {
          score_offset = 800, -- Boost score to prioritize over other sources
          preset = "luasnip",
          min_keyword_length = 2,
        }, ]]
        lsp = {
          score_offset = 900, -- Boost score to prioritize over other sources
          min_keyword_length = 2, -- Número de caracteres para acionar o provedor
        },
        buffer = {
          min_keyword_length = 5,
          max_items = 5,
        },
        path = {
          min_keyword_length = 0,
        },
      },
    },
  },
  -- Customização de ícones
  kind_icons = {
    AvanteCmd = "󰚩",
    AvanteMention = "󰐕",
    Class = "󰠱",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Enum = "󰕘",
    EnumMember = "󰆕",
    Event = "󰉁",
    Field = "󰜢",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = "󰜰",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Operator = "󰆕",
    Property = "󰜢",
    Reference = "󰈇",
    Snippet = "",
    Struct = "󰙅",
    Text = "󰉿",
    TypeParameter = "",
    Unit = "󰑭",
    Value = "󰎠",
    Variable = "󰀫",
  },
}
