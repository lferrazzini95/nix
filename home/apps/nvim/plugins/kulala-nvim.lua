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

map("n", "<leader>Rd", function()
  local logger = require("kulala.logger")

  if logger.level == "debug" then
    logger.level = "warn"
    vim.notify("[Kulala] Debug mode OFF", vim.log.levels.WARN)
  else
    logger.level = "debug"
    logger.log_file = vim.fn.stdpath("cache") .. "/kulala.log"
    vim.notify("[Kulala] Debug mode ON (logging to kulala.log)", vim.log.levels.INFO)
  end
end, { desc = "[D]ebug toggle"})
