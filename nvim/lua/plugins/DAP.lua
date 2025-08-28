return {
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
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

      dap.adapters.java = {
        type = "executable",
        command = "$HOME/.local/share/nvim/mason/bin/vscode-java-debug",
        options = {
          cwd = vim.fn.getcwd(),
        },
      }

      dap.configurations.java = {
        {
          name = "Launch Current File",
          type = "java",
          request = "launch",
          mainClass = "${file}",
        },
        {
          name = "Attach to Remote JVM",
          type = "java",
          request = "attach",
          hostName = "localhost", -- Or 127.0.0.1
          port = 5005,
        },
      }
    end,
  },
}

