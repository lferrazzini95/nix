{ pkgs, userTheme, ... }:
let
  nvim-theme =
    if userTheme == "nordic" then
      pkgs.vimPlugins.nordic-nvim
    else if userTheme == "everforest" then
      pkgs.vimPlugins.everforest
    else
      pkgs.vimPlugins.defaultTheme;
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/null-ls.lua;
      }
      bufferline-nvim
      render-markdown-nvim
      nvim-dap
      lsp-zero-nvim
      {
        plugin = kulala-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/kulala-nvim.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-lspconfig.lua;
      }
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/blink-cmp.lua;
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-tree.lua;
      }
      {
       plugin = nvim-treesitter.withAllGrammars;
       type = "lua";
       config = builtins.readFile ./plugins/nvim-treesitter.lua;
       }
      rainbow-delimiters-nvim
      telescope-nvim
      vim-commentary
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

      shfmt
      shellharden

      gofumpt
      goimports-reviser
      revive

      gopls
      yaml-language-server
      helm-ls
      marksman
      rust-analyzer
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
