require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Blame line (full)
    vim.keymaps.set("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, opts, { desc = "[B]lame hunk" })
  end,
})
