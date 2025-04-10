local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Define LSP servers and their specific configurations
local lsp_servers = {
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
			nix = {},
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

-- Loop through servers and set them up with shared capabilities
for server in lsp_servers do
	require("lspconfig")[server].setup({ capabilities = capabilities })
end

-- local capabilities = require("blink.cmp").get_lsp_capabilities()
-- require("lspconfig").pyright.setup({
-- 	capabilities = capabilities,
-- 	-- on_attach = lsp_on_attach, -- Ensure this is correctly hooked up
-- 	python = {
-- 		analysis = {
-- 			typeCheckingMode = "strict", -- "off", "basic", or "strict"
-- 			-- Check for unused variables and other issues
-- 			diagnosticMode = "openFiles", -- Only diagnose open files or all files
-- 			useLibraryCodeForTypes = true,
-- 			autoSearchPaths = true,
-- 		},
-- 	},
-- })
-- require("lspconfig").nil_ls.setup({
-- 	-- on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
-- 	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
-- 	settings = {
-- 		nix = {
-- 			-- Nix-specific settings here if needed
-- 		},
-- 	},
-- })
-- require("lspconfig").lua_ls.setup({
-- 	-- on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
-- 	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
-- 	settings = {},
-- })

-- require("lspconfig").dartls.setup({
-- 	-- on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
-- 	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
-- 	settings = {},
-- })

-- require("lspconfig").gopls.setup({
-- 	-- on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
-- 	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
-- 	settings = {
-- 		gopls = {
-- 			analyses = {
-- 				unusedparams = true, -- Enable unused params analysis
-- 				shadow = true, -- Enable shadowed variables detection
-- 			},
-- 			staticcheck = true, -- Enable staticcheck for Go
-- 			gofumpt = true, -- Enable gofumpt (Go formatting tool)
-- 			usePlaceholders = true, -- Enable placeholders for code completion
-- 		},
-- 	},
-- })
