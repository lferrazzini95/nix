{
  pkgs,
  pkgs-stable,
  ...
}: let
  neorg-templates = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-templates";
    src = pkgs.fetchFromGitHub {
      owner = "pysan3";
      repo = "neorg-templates";
      rev = "v2.0.3";
      sha256 = "sha256-nZOAxXSHTUDBpUBS/Esq5HHwEaTB01dI7x5CQFB3pcw=";
    };
    propagatedBuildInputs = with pkgs.luajitPackages; [luasnip neorg];
    dependencies = [
      pkgs.vimPlugins.neorg
    ];
  };
  neopywal = pkgs.vimUtils.buildVimPlugin {
    name = "neopywal.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "RedsXDD";
      repo = "neopywal.nvim";
      rev = "v2.6.0";
      sha256 = "sha256-P28gg5fPPPyhepPHOZFgMnGTToCXK+v4ev6oTRSZXtg=";
    };
    doCheck = false;
  };
in {
  home.file = {
    ".config/nvim/templates/norg/journal.norg" = {
      source = ./templates/norg/journal.norg;
    };
  };

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
      vim-be-good
      bufferline-nvim
      telescope-nvim
      vim-commentary
      markdown-preview-nvim
      neorg-templates
      neorg-telescope
      neopywal
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./plugins/luasnip.lua;
      }
      {
        plugin = neorg;
        type = "lua";
        config = builtins.readFile ./plugins/neorg.lua;
      }
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
    ];
    extraLuaConfig = builtins.readFile ./config/init.lua;
    extraPackages = with pkgs; [
      deadnix
      statix
      alejandra
      cbfmt
      ty

      shfmt
      shellharden

      gofumpt
      goimports-reviser
      revive
      rust-analyzer
      rustfmt

      jdt-language-server
      gopls
      yaml-language-server
      helm-ls
      marksman
      terraform-ls
      nil

      universal-ctags

      clippy
      harper

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
