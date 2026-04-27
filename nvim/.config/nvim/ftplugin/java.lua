local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local root_markers = { "pom.xml", "build.gradle", "mvnw", "gradlew", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"

local config = {
  cmd = {
    mason_path .. "/bin/jdtls",
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {
    java = {},
  },
  init_options = {},
}

jdtls.start_or_attach(config)
