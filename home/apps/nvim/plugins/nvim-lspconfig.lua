local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Shared LSP config
local capabilities = require("blink.cmp").get_lsp_capabilities()
local function on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
end

----------------------------------------------------------------------
-- Harper (spelling) 
----------------------------------------------------------------------
vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      fileDictPath = "",
      linters = {
        BoringWords = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "British",
    },
  },
})
vim.lsp.enable("harper_ls")

----------------------------------------------------------------------
-- ty (Custom Python Type Checker)
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
-- nil_ls (Nix Language Server)
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
-- lua_ls
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
-- dartls
----------------------------------------------------------------------

vim.lsp.config("dartls", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings
})
vim.lsp.enable("dartls")

----------------------------------------------------------------------
-- gopls
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
-- jdtls (Java)
----------------------------------------------------------------------

vim.lsp.config("jdtls", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings
})
vim.lsp.enable("jdtls")

----------------------------------------------------------------------
-- rust_analyzer
----------------------------------------------------------------------

vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- No custom settings in your provided block
})
vim.lsp.enable("rust_analyzer")
