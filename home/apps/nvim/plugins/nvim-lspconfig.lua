local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Register 'ty' server
if not configs.ty then
  configs.ty = {
    default_config = {
      cmd = { "ty", "server" },
      filetypes = { "python" },
      root_dir = util.root_pattern("pyproject.toml", ".git"),
    },
  }
end

-- Shared LSP config
local capabilities = require("blink.cmp").get_lsp_capabilities()
local on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

-- Define server-specific settings
local servers = {
  ty = {},
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
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
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
	rust_analyzer = {},
	jdtls = {},
}

-- Apply shared config and setup
for name, config in pairs(servers) do
	config.on_attach = on_attach
	config.capabilities = capabilities
	lspconfig[name].setup(config)
end
