local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Define LSP servers and their specific configurations
local lsp_server_configs = {
  pyright = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        diagnosticMode = "openFiles",
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
      },
    },
  },
  nil_ls = {
    settings = {
      ["nil"] = {
        formatting = {
            command = {"alejandra", "--quiet" },
      },
    },
  },
  lua_ls = {},
  dartls = {},
  gopls = {
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
  },
}
}

-- Loop through servers and set them up with shared capabilities
for server, config in pairs(lsp_server_configs) do
  require("lspconfig")[server].setup({ capabilities = capabilities, config })
end
