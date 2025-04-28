require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		go = { "gofmt" },
		helm = { "prettier_yaml" },
		yaml = { "prettier_yaml" },
		nix = { "nixfmt" },
	},
	formatters = {
		prettier_yaml = {
			command = "prettier",
			args = {
				"--no-bracket-spacing",
			},
		},
	},
})
