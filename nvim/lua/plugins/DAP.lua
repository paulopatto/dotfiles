return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Key maps
      -- See :help dap.txt, :help dap-mapping and :help dap-api.
      -- debug toogle (breakpoint)
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
      -- debug continue: Launching debug sessions and resuming execution via
      vim.keymap.set("n", "<Leader>dc", dap.continue, {})
      -- debug step (over): Stepping through code over the line
      vim.keymap.set("n", "<Leader>ds", dap.step_over, {})
      -- debug (step) into: Stepping through code into the function
      vim.keymap.set("n", "<Leader>di", dap.step_into, {})
      -- debug repl: Inspecting the state via the built-in REPL
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependecies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      --[[ local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path) ]]
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      local dap_virtual_text = require("nvim-dap-virtual-text")

      dap_virtual_text.setup({
        enabled = true,      -- enable this plugin (the default)
        enabled_commands = true, -- create commands
        -- * DapVirtualTextEnable
        -- * DapVirtualTextDisable
        -- * DapVirtualTextToggle
        highlight_changed_variables = true,                             -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,                               -- highlight new variables in the same way as changed variables
        show_stop_reason = true,                                        -- show stop reason when stopped for exceptions
        commented = false,                                              -- prefix virtual text with comment string
        only_first_definition = true,                                   -- only show virtual text at first definition (if there are multiple)
        all_references = false,                                         -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false,                                      -- clear virtual text on "continue" (might cause flickering when stepping)
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- This line is essential to making automatic installation work
      -- :exploding-brain
      -- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
      handlers = {},
      automatic_installation = {
        exclude = {
          "python",
        },
        ensure_installed = {
          "python",
          "debugpy",
        },
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "python",
          "debugpy",
        },
      })
    end,
  },
}

