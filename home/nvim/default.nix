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
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/conform.lua;
      }
      bufferline-nvim
      render-markdown-nvim
      nvim-dap
      lsp-zero-nvim
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
      nvim-treesitter.withAllGrammars
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
      pyright
      gopls
      nil
      nodePackages.prettier
      black
      nixfmt-rfc-style
      stylua
    ];
  };
}
