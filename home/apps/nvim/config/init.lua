vim.g.mapleader = " " -- Sets <Space> as the leader key

---------------------------
-- Configure diagnostics --
---------------------------
vim.o.updatetime = 300

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = false,
  update_in_insert = false, -- Don't update diagnostics while typing
})

----------------------
-- General Settings --
----------------------
-- Set clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Set tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Set linenumbervisibility
vim.wo.number = true
-- vim.wo.relativenumber = true

-------------------------------
-- Configure window settings --
-------------------------------
vim.api.nvim_set_keymap("n", "<C-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":resize -2<CR>", { noremap = true, silent = true })

---------------------------------
-- Configure general utilities --
---------------------------------
vim.api.nvim_set_keymap("n", "<Leader>us", ":%!sort<CR>", { noremap = true, silent = true, desc = "[S]ort Lines" })

vim.api.nvim_set_keymap(
  "n",
  "<Leader>ut",
  ":belowright split | resize " .. math.floor(vim.o.lines / 3) .. " | terminal<CR>",
  { noremap = true, silent = true, desc = "[T]erminal" }
)

---------------------------------
-- Configure toggles --
---------------------------------
require("render-markdown").setup({})
vim.api.nvim_set_keymap(
  "n",
  "<leader>tm",
  ":RenderMarkdown toggle<CR>",
  { noremap = true, silent = true, desc = "[M]arkdown" }
)
vim.keymap.set("n", "<leader>tl", function()
  vim.wo.number = not vim.wo.number
end, { noremap = true, silent = true, desc = "[L]inenumbers" })

vim.keymap.set('n', '<leader>tr', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "[R]elative Linenumbers" })
-------------------------------------
-- Configure search/find utilities --
-------------------------------------
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[H]elp" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[G]rep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[B]uffers" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[W]ord" })

---------------------------
-- Configure bufferlines --
---------------------------
require("bufferline").setup({
  options = {
    separator_style = "thin",
  },
})
vim.api.nvim_set_keymap(
  "n",
  "<Leader>bn",
  ":BufferLineCycleNext<CR>",
  { noremap = true, silent = true, desc = "[N]ext" }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>bp",
  ":BufferLineCyclePrev<CR>",
  { noremap = true, silent = true, desc = "[P]revious" }
)
vim.api.nvim_set_keymap("n", "<Leader>bs", ":BufferLinePick<CR>", { noremap = true, silent = true, desc = "[S]elect" })

vim.api.nvim_set_keymap("n", "<Leader>bw", ":w<CR>", { noremap = true, silent = true, desc = "[W]rite" })
----------------------------
-- Configure LSP settings --
----------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- The timeout is a safeguard against the LSP server hanging
    vim.lsp.buf.format({ async = true, timeout_ms = 2000 })
  end,
})
vim.api.nvim_set_keymap(
  "n",
  "<Leader>cf",
  ":lua vim.lsp.buf.format({ async = true })<CR>",
  { noremap = true, silent = true, desc = "[F]ormat" }
)
vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, {
  buffer = bufnr,
  desc = "[S]ignature",
})

---------------------------
-- Configure UI settings --
---------------------------
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-------------------
-- Configure LSP --
-------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    vim.keymap.set("n", "<leader>ds", function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        border = "rounded", -- Set border for the diagnostic float here
        scope = "line", -- Show diagnostics for the current line
      })
    end, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = "[S]how",
    })

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = "[D]efinition",
    })

    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = "[I]mplementation",
    })

    vim.keymap.set("n", "<leader>gr", require('telescope.builtin').lsp_references, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = "[R]eferences",
    })
  end,
})
