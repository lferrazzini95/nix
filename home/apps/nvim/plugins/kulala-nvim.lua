require("kulala").setup({
  global_keymaps = false,
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "",
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>Rs", function() require("kulala").run() end, { desc = "[R]equest [s]end" })
map("n", "<leader>Ra", function() require("kulala").run_all() end, { desc = "[R]equest send [a]ll" })
map("n", "<leader>Rb", function() require("kulala").scratchpad() end, { desc = "[R]equest scratch [b]lock" })

-- As for lazy-loading by filetype, you would wrap the above code in an autocmd:
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "http", "rest" },
--   callback = function()
--     -- Put the require('kulala').setup() and vim.keymap.set calls here
--   end,
-- })
