return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Availables LSP Servers
				-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
				ensure_installed = {
					"jdtls",
					"kotlin_language_server",
					"lua_ls",
					"pyright",
					"ruff",
					"solargraph",
					"tailwindcss",
					"terraformls",
					"ts_ls",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" }, -- Carrega apenas para arquivos Java
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local java_path = vim.fn.expand("~/.asdf/shims/java")
			local jdtls = require("jdtls")
			local on_attach = require("cmp_nvim_lsp").on_attach

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "python" },
      })
      lspconfig.ruff.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "python" },
      })
      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
      })
      lspconfig.jdtls.setup({
        cmd = { "jdtls" },
        root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git", "gradlew", "mvnw"), -- Define o diretório raiz do projector
        settings = {
          java = {
            configuration = {
              maven = {
                userSettings = nil,
                globalSettings = nil,
              },
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = java_path, -- Usa o caminho do JDK gerenciado pelo asdf
                  default = true,
                },
              },
            },
          },
        },
      })

      jdtls.start_or_attach({
        cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls") }, -- Caminho do jdtls
        root_dir = vim.fs.dirname(
          vim.fs.find({ "pom.xml", "build.gradle", ".git", "gradlew", "mvnw" }, { upward = true })[1]
        ), -- Define o diretório raiz do projeto
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = java_path, -- Usa o caminho do JDK gerenciado pelo asdf
                },
              },
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              format = { enabled = true },
            },
          },
        },
      })

      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- Read more: https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- Will open helper pop-up
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- Format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Format", { clear = true }),
        callback = function()
          vim.lsp.buf.format()
        end,
      })

      -- Add blankline at EOF on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("AddBlankLine", { clear = true }),
        callback = function()
          local last_line = vim.api.nvim_buf_line_count(0)
          local last_line_content = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, false)[1]
          if last_line_content ~= "" then
            vim.api.nvim_buf_set_lines(0, last_line, last_line, false, { "" })
          end
        end,
      })

      -- Organize import
      vim.keymap.set({ "n", "v" }, "<leader>oi", function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source.organizeImports" },
          },
        })
      end)
    end,
  },
}

