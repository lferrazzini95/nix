local function show_line_diagnostics()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		border = "rounded",
		scope = "line",
	})
end

local function lsp_on_attach()
	vim.keymap.set(
		"n",
		"<leader>ds",
		show_line_diagnostics,
		{ noremap = true, silent = true, desc = "Show line diagnostics" }
	)
	vim.keymap.set(
		"n",
		"<leader>dd",
		vim.lsp.buf.definition,
		{ noremap = true, silent = true, desc = "Go to definition" }
	)
	vim.keymap.set("n", "<leader>dr", "<C-o>", { noremap = true, silent = true, desc = "Go back" })

	-- Automatically show diagnostics on CursorHold
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = 0,
		callback = show_line_diagnostics,
	})
end

capabilities = require("blink.cmp").get_lsp_capabilities()

require("lspconfig").pyright.setup({
	capabilities = capabilities,
	on_attach = lsp_on_attach, -- Ensure this is correctly hooked up
	python = {
		analysis = {
			typeCheckingMode = "strict", -- "off", "basic", or "strict"
			-- Check for unused variables and other issues
			diagnosticMode = "openFiles", -- Only diagnose open files or all files
			useLibraryCodeForTypes = true,
			autoSearchPaths = true,
		},
	},
})

require("lspconfig").nil_ls.setup({
	on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
	settings = {
		nix = {
			-- Nix-specific settings here if needed
		},
	},
})

require("lspconfig").lua_ls.setup({
	on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
	settings = {},
})

require("lspconfig").gopls.setup({
	on_attach = lsp_on_attach, -- Attach the diagnostics and keymap setup
	capabilities = capabilities, -- Use your defined LSP capabilities (if any)
	settings = {
		gopls = {
			analyses = {
				unusedparams = true, -- Enable unused params analysis
				shadow = true, -- Enable shadowed variables detection
			},
			staticcheck = true, -- Enable staticcheck for Go
			gofumpt = true, -- Enable gofumpt (Go formatting tool)
			usePlaceholders = true, -- Enable placeholders for code completion
		},
	},
})
