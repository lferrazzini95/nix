require("which-key").setup({
	spec = {
		{ "<leader>c", group = "[C]ode", mode = { "n", "v" } },
		{ "<leader>d", group = "[D]ocument", mode = { "n", "v" } },
		{ "<leader>b", group = "[B]uffer", mode = { "n", "v" } },
		{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
		{ "<leader>w", group = "[W]orkspace", mode = { "n", "v" } },
		{ "<leader>t", group = "[T]oggle", mode = { "n", "v" } },
		{ "<leader>u", group = "[U]tilities", mode = { "n", "v" } },
		--{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
	},
})
