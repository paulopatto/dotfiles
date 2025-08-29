return {
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
      local dap = require("dap-python")

      -- calls dap python run file
      vim.keymap.set("n", "<leader>dpr", dap.test_method, {})
    end,
  },
}

