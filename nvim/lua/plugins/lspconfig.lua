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
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Setup language servers installed through Mason
      local servers = mason_lspconfig.get_installed_servers()
      for _, server_name in ipairs(servers) do
        -- Exclude jdtls from the general setup, as it has a custom one
        if server_name ~= "jdtls" then
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      end

      -- Custom setup for jdtls
      local java_path = vim.fn.expand("~/.asdf/shims/java")
      local jdtls = require("jdtls")
      lspconfig.jdtls.setup({
        cmd = { "jdtls" },
        root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git"),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = java_path,
                },
              },
            },
          },
        },
      })
      jdtls.start_or_attach({
        cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls") },
        root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "build.gradle", ".git" }, { upward = true })[1]),
      })

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
