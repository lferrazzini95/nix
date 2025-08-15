local capabilities = require("blink.cmp").get_lsp_capabilities()

local on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end
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
          command = { "alejandra", "--quiet" },
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- ✅ Tell the server about the 'vim' global
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
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
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}

-- Loop through servers and set them up with shared capabilities
for server, config in pairs(lsp_server_configs) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  require("lspconfig")[server].setup(config)
end
