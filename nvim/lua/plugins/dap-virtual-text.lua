return {
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      local dap_virtual_text = require("nvim-dap-virtual-text")

      dap_virtual_text.setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands
        -- * DapVirtualTextEnable
        -- * DapVirtualTextDisable
        -- * DapVirtualTextToggle
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      })
    end,
  },
}

