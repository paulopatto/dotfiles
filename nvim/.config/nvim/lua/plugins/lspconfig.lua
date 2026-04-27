return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local default_config = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local use_new_api = vim.version().minor >= 11

      if use_new_api then
        vim.lsp.config("terraformls", {
          filetypes = { "terraform", "tf", "hcl" },
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("kotlin_language_server", {
          filetypes = { "kotlin" },
          on_attach = on_attach,
          capabilities = capabilities,
        })

        if mason_lspconfig.setup_handlers then
          mason_lspconfig.setup_handlers({
            function(server_name)
              if server_name ~= "jdtls" and server_name ~= "stylua" then
                vim.lsp.config(server_name, default_config)
              end
            end,
          })
        else
          local servers = mason_lspconfig.get_installed_servers()
          for _, server_name in ipairs(servers) do
            if server_name ~= "jdtls" and server_name ~= "stylua" then
              vim.lsp.config(server_name, default_config)
            end
          end
        end
      else
        local lspconfig = require("lspconfig")

        local function setup_server(server_name, custom_config)
          local config = custom_config or default_config
          local ok, server = pcall(function()
            return lspconfig[server_name]
          end)
          if ok and server and server.setup then
            pcall(server.setup, config)
          end
        end

        if pcall(function() return lspconfig.terraformls end) then
          setup_server("terraformls", {
            filetypes = { "terraform", "tf", "hcl" },
          })
        end

        if pcall(function() return lspconfig.kotlin_language_server end) then
          setup_server("kotlin_language_server", {
            filetypes = { "kotlin" },
          })
        end

        if mason_lspconfig.setup_handlers then
          mason_lspconfig.setup_handlers({
            function(server_name)
              if server_name ~= "jdtls" and server_name ~= "stylua" then
                setup_server(server_name)
              end
            end,
          })
        else
          local servers = mason_lspconfig.get_installed_servers()
          for _, server_name in ipairs(servers) do
            if server_name ~= "jdtls" and server_name ~= "stylua" then
              setup_server(server_name)
            end
          end
        end
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set({ "n", "v" }, "<leader>oi", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })
      end, { desc = "Organize Imports" })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
        callback = function(args)
          vim.lsp.buf.format({ bufnr = args.buf })
        end,
      })
    end,
  },
}