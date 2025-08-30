{
  pkgs,
  pkgs-stable,
  userTheme,
  ...
}: let
  nvim-theme =
    if userTheme == "nordic"
    then pkgs.vimPlugins.nordic-nvim
    else if userTheme == "everforest"
    then pkgs.vimPlugins.everforest
    else pkgs.vimPlugins.defaultTheme;
in {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      #---- lsp/dap/completion ----#
      nvim-dap
      nvim-java
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/blink-cmp.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-lspconfig.lua;
      }
      {
        plugin = pkgs-stable.vimPlugins.nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-treesitter.lua;
      }
      {
        plugin = none-ls-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/none-ls.lua;
      }
      #---- utilities ----#
      bufferline-nvim
      telescope-nvim
      vim-commentary
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns-nvim.lua;
      }
      {
        plugin = pkgs-stable.vimPlugins.kulala-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/kulala-nvim.lua;
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-tree.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/which-key.lua;
      }
      {
        plugin = renamer-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/renamer.lua;
      }
      #---- visuals ----#
      render-markdown-nvim
      rainbow-delimiters-nvim
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-colorizer-lua.lua;
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/indent-blankline-nvim.lua;
      }
      {
        plugin = nvim-theme;
        type = "lua";
        config = "vim.cmd('colorscheme ${userTheme}')";
      }
    ];
    extraLuaConfig = builtins.readFile ./config/init.lua;
    extraPackages = with pkgs; [
      deadnix
      statix
      alejandra
      cbfmt
      pyright

      shfmt
      shellharden

      gofumpt
      goimports-reviser
      revive
      pkgs-stable.rust-analyzer

      jdt-language-server
      gopls
      yaml-language-server
      helm-ls
      marksman
      rustfmt
      terraform-ls
      nil

      universal-ctags

      clippy

      stylua
      lua-language-server
      selene

      yamlfmt

      libxml2

      tfsec

      fzf

      html-tidy

      tinymist
      typstyle
    ];
  };
}
