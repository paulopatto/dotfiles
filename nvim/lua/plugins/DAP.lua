return {
  {
    "mfussenegger/nvim-dap",
    dependencie = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim", -- same of LSP module
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      -- Key maps
      vim.keymap.set("n", '<Leader>bp', dap.toggle_breakpoint, {})
      vim.keymap.set("n", '<Leader>dc', dap.continue, {}) -- debug continue


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

      require("mason-nvim-dap").setup({
        automatic_installation = true,
      })
    end
  },
}
