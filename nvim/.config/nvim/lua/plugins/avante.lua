return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  -- lazy = false,
  --version = false, -- Use main branch (necessario para suporte ACP/opencode)
  version = "*", -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = false,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function(_, opts)
    -- Captura o provider ANTES do setup
    local provider_antes = opts.provider
    print("[AVANTE-DIAG] provider no opts antes do setup: " .. tostring(provider_antes))

    -- Monkey-patch para capturar mudanças em Config.provider
    local Config = require("avante.config")
    local original_provider = opts.provider

    -- Intercepta o override para logar mudanças
    local original_override = Config.override
    Config.override = function(self, override_opts)
      if override_opts and override_opts.provider then
        print("[AVANTE-DIAG] Config.override chamado com provider: " .. tostring(override_opts.provider))
      end
      return original_override(self, override_opts)
    end

    require("avante").setup(opts)

    -- Verifica o provider após setup
    print("[AVANTE-DIAG] Config.provider após setup: " .. tostring(Config.provider))
    print("[AVANTE-DIAG] Config.acp_providers[opencode]: " .. tostring(Config.acp_providers["opencode"] ~= nil))

    -- Intercepta Providers.__index para logar acessos
    local Providers = require("avante.providers")
    local original_index = getmetatable(Providers).__index
    getmetatable(Providers).__index = function(t, k)
      if k == "setup" or k == "get_config" or k == "get_memory_summary_provider" or k == "refresh" then
        return original_index(t, k)
      end
      print("[AVANTE-DIAG] Providers[" .. tostring(k) .. "] acessado, Config.provider = " .. tostring(Config.provider))
      return original_index(t, k)
    end
  end,
  opts = {
    debug = true,
    log_level = vim.log.levels.DEBUG,
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "opencode" | string
    -- add any opts here
    -- for example
    providers = {
      openai = {
        model = "gpt-5-mini",
        timeout = 30000,
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-3.1-flash-lite",
        api_key_name = "AVANTE_GEMINI_API_KEY",
        max_tokens = 8192,
        timeout = 3000,
      },
      openrouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "deepseek/deepseek-r1",
        timeout = 30000,
        max_tokens = 8192,
        -- Nova exigência do Avante: metadados específicos da requisição vão aqui
        extra_request_body = {
          -- Força o OpenRouter a injetar os headers necessários para ferramentas Agentic do ecossistema OpenCode
          plugins = { "opencode" },
          transforms = {}, -- Evita que prompts muito longos sejam comprimidos por padrão
          max_tokens = 32768,
        },
        headers = {
          ["X-Title"] = "Neovim AI",
        },
      },
    },

    -- Configura o OpenCode através do protocolo ACP (Agent Client Protocol)
    -- Link: https://opencode.ai/docs/acp/#avantenvim
    acp_providers = {
      ["opencode"] = {
        command = "opencode",
        args = { "acp" },
        env = {
          OPENCODE_API_KEY = os.getenv("OPENCODE_API_KEY"),
        },
      },

      ["codex"] = {
        command = "codex",
        args = { "acp" },
      },
    },

    ---@alias Mode "agentic" | "legacy"
    ---@type Mode
    mode = "agentic", -- The default mode for interaction. "agentic" uses tools to automatically generate code, "legacy" uses the old planning method to generate code.
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.

    provider = "openai",
    auto_suggestions_provider = "gemini",
    memory_summary_provider = "gemini",

    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.
    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = "openai",
      second_provider = "gemini",
      timeout = 60000, -- Timeout in milliseconds
      prompt = [[
      Act as a Principal Software Architect with strong expertise in Cybersecurity, Cloud and DevOps.

      Combine the two candidate responses into one superior solution.

      Always prioritize:
      - Correctness
      - Security by Design
      - Simplicity
      - Clean Architecture
      - Maintainability
      - Performance
      - Scalability
      - Operational Excellence

      For code:
      - Use secure defaults.
      - Eliminate bugs, vulnerabilities and anti-patterns.
      - Prefer cleat, idiomatic, production-ready implementations and well-structured code.
      - Follow SOLID, DRY and KISS only when they improve the solution.

      For Infrastructure:
      - Follow IaC and GitOps best practices.
      - Enforce least privilege.
      - Never expose secrets.
      - Prefer immutable, reproducible and observable deployments.

      Choose the strongest ideas from each response.
      Remove redundant, conflicting or lower-quality content.
      Return only the final answer.

      Return only the final answer.

      Reference 1:
      {{provider1_output}}

      Reference 2:
      {{provider2_output}}
      ]],
    },

    behaviour = {
      auto_suggestions = true, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
      enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
    },

    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
  },
}
