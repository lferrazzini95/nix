local function edit_or_open()
  local api = require("nvim-tree.api")

  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

vim.keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "s", api.node.open.vertical, opts("open file in vertical mode"))
  vim.keymap.set("n", "l", edit_or_open, opts("open file or expand folder"))

  vim.keymap.set("n", "h", function()
    api.node.open.parent()
  end, opts("collapse folder"))
  -- local node = api.tree.get_node_under_cursor()
  -- if node then
  --   api.node.open.edit()
  -- end
  -- end, opts("open file or expand folder"))
  -- vim.keymap.set("n", "h", function()
  -- local node = api.tree.get_node_under_cursor()
  -- if node and node.type == "directory" and node.open then
  --   api.node.open.edit()
  -- end
  -- end, opts("collapse folder"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  renderer = {
    highlight_opened_files = "all",
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      -- hint = "",
      -- info = "",
      -- warning = "",
      error = "",
    },
  },
})
