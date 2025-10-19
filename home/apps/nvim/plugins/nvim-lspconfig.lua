local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Shared LSP config
local capabilities = require("blink.cmp").get_lsp_capabilities()
local function on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end
----------------------------------------------------------------------
-- 1. ty (Custom Python Type Checker)
----------------------------------------------------------------------
if not configs.ty then
  configs.ty = {
    default_config = {
      cmd = { "ty", "server" },
      filetypes = { "python" },
      root_dir = util.root_pattern("pyproject.toml", ".git"),
    },
  }
end

vim.lsp.config("ty", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("ty")

----------------------------------------------------------------------
-- 2. nil_ls (Nix Language Server)
----------------------------------------------------------------------

vim.lsp.config("nil_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra", "--quiet" },
      },
    },
  },
})
vim.lsp.enable("nil_ls")

----------------------------------------------------------------------
-- 3. lua_ls
----------------------------------------------------------------------

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
vim.lsp.enable("lua_ls")

----------------------------------------------------------------------
-- 4. dartls
----------------------------------------------------------------------

vim.lsp.config("dartls", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings
})
vim.lsp.enable("dartls")

----------------------------------------------------------------------
-- 5. gopls
----------------------------------------------------------------------

vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
    },
  },
})
vim.lsp.enable("gopls")

----------------------------------------------------------------------
-- 6. jdtls (Java)
----------------------------------------------------------------------

vim.lsp.config("jdtls", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings
})
vim.lsp.enable("jdtls")

----------------------------------------------------------------------
-- 7. rust_analyzer
----------------------------------------------------------------------

vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings in your provided block
})
vim.lsp.enable("rust_analyzer")
