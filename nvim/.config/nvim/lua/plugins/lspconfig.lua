return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      -- mason-lspconfig is initialized in its own plugin config
      -- Ensure Mason binaries are in PATH
      vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Setup language servers (compat: new + old mason-lspconfig)
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            if server_name ~= "jdtls" and server_name ~= "stylua" then
              local ok, server = pcall(function()
                return lspconfig[server_name]
              end)
              if ok and server then
                server.setup({
                  on_attach = on_attach,
                  capabilities = capabilities,
                })
              end
            end
          end,

          ["terraformls"] = function()
            require("lspconfig").terraformls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "terraform", "tf", "hcl" },
            })
          end,

          ["kotlin_language_server"] = function()
            require("lspconfig").kotlin_language_server.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "kotlin" },
            })
          end,
        })
      else
        local servers = mason_lspconfig.get_installed_servers()
        for _, server_name in ipairs(servers) do
          if server_name ~= "jdtls" and server_name ~= "stylua" then
            local ok, server = pcall(function()
              return lspconfig[server_name]
            end)
            if ok and server then
              server.setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end
          end
        end
      end

      -- Custom setup for jdtls
      -- jdtls is handled via ftplugin/java.lua (proper lazy + per-project setup)

      -- Global keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set({ "n", "v" }, "<leader>oi", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })
      end, { desc = "Organize Imports" })

      -- Format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
        callback = function(args)
          vim.lsp.buf.format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
