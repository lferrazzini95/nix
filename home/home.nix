{
  pkgs,
  username,
  userTheme,
  ...
}: let
  themePackage =
    if userTheme == "nordic"
    then pkgs.nordic
    else if userTheme == "everforest"
    then pkgs.everforest-gtk-theme
    else pkgs.defaultTheme;
in {
  #Manage Appearance
  gtk = {
    enable = true;
    theme = {
      package = themePackage;
      name = userTheme;
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        "picture-uri" = "/home/${username}/.background-image";
        "picture-uri-dark" = "/home/${username}/.background-image";
      };
      "org/gnome/desktop/screensaver" = {
        "picture-uri" = "/home/${username}/.background-image";
        "picture-uri-dark" = "/home/${username}/.background-image";
      };
      "org/gnome/desktop/interface" = {
        "color-scheme" = "prefer-dark";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "brave-browser.desktop"
          "Alacritty.desktop"
        ];
      };
    };
  };
  home.file.".background-image".source = ./ui/${userTheme}.jpg;

  home.stateVersion = "24.05";
  #Manage applications
  imports = [
    (import ./apps/nvim/default.nix {inherit pkgs userTheme;})
    (import ./apps/git/default.nix {inherit pkgs userTheme;})
    (import ./apps/alacritty/default.nix {inherit pkgs userTheme;})
    (import ./apps/tmux/default.nix {inherit pkgs userTheme;})
    (import ./apps/k9s/default.nix {inherit pkgs userTheme;})
    (import ./apps/bash/default.nix {inherit pkgs userTheme;})
    (import ./apps/gpg/default.nix {inherit pkgs;})
    (import ./apps/starship/default.nix {inherit pkgs userTheme;})
  ];
  home.packages = with pkgs; [
    atool
    httpie

    #administration
    kubectl
    kubectx
    _1password-gui
    _1password

    #programming
    go
    dart

    #utils
    jq
    zip
    fzf
    openssl

    #env
    devbox

    #hobby
    bambu-studio
    jellyfin-media-player
    spotify
    steam
    ardour
  ];

  home.file = {
    ".local/bin/gpf" = {
      source = ./scripts/gpf;
      executable = true;
    };
  };
  services.syncthing = {
    enable = true;
  };

  programs = {
    home-manager.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
