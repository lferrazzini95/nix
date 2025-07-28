require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  auto_install = false,
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = "rainbow-delimiters",
    strategy = require("rainbow-delimiters").strategy.global,
  },
  indent = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
