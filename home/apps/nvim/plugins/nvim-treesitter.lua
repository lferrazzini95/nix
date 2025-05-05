require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
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
