local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.set_log_level("debug")

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
	rust_analyzer = {},
	jdtls = {},

}

-- Loop through servers and set them up with shared capabilities
local lspconfig = require("lspconfig")
for server, config in pairs(lsp_server_configs) do
	config.on_attach = on_attach
	config.capabilities = capabilities
	lspconfig[server].setup(config)
end
