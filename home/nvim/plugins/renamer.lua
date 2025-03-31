-- Ensure renamer plugin is installed and setup
require("renamer").setup({
	-- Add plugin-specific settings, e.g., show_cursor
	show_cursor = true,
})

-- Correct key mapping for renaming in visual mode
vim.api.nvim_set_keymap("v", "<leader>ur", '<cmd>lua require("renamer").rename()<CR>', {
	noremap = true,
	silent = true,
	desc = "[R]ename", -- Description for which-key or your keybinding display plugin
})
