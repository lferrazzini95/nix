{
  pkgs,
  pkgs-stable,
  username,
  fullName,
  email,
  lib,
  ...
}: let
  cursorPackage = pkgs.capitaine-cursors-themed;
  cursorPackageName = "Capitaine Cursors (Gruvbox)";
in {
  home.stateVersion = "24.05";

  imports = [
    (import ./apps/nvim/default.nix {inherit pkgs pkgs-stable;})
    (import ./apps/git/default.nix {inherit pkgs username fullName email;})
    (import ./apps/alacritty/default.nix {inherit pkgs;})
    (import ./apps/kitty/default.nix {inherit pkgs;})
    (import ./apps/tmux/default.nix {inherit pkgs lib;})
    (import ./apps/k9s/default.nix {inherit pkgs;})
    (import ./apps/bash/default.nix {inherit pkgs;})
    (import ./apps/gpg/default.nix {inherit pkgs;})
    (import ./apps/starship/default.nix {inherit pkgs;})
    (import ./apps/rofi/default.nix {inherit pkgs username lib;})
    (import ./apps/hyprland/default.nix {inherit pkgs username lib;})
  ];

  #Manage Appearance
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      package = cursorPackage;
      name = cursorPackageName;
      size = 32;
    };
  };

  home.file = {
    ".local/share/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
    ".local/bin/walselect" = {
      source = ./scripts/wallpaper-select;
      executable = true;
    };
    ".local/bin/brain-toggle" = {
      source = ./scripts/brain-toggle;
      executable = true;
    };
    ".local/bin/play-notification.sh" = {
      text = ''
        #!/bin/sh
        ffplay -v 0 -nodisp -autoexit /home/${username}/.local/share/sounds/notification.mp3
      '';
      executable = true;
    };
  };

  home.packages = with pkgs; [
    atool
    httpie
    brave

    #administration
    kubectl
    kubectx

    #programming
    go
    dart
    kubernetes-helm

    #utils
    jq
    zip
    fzf
    openssl
    wl-clipboard
    wl-screenrec
    slurp
    grim
    gcc
    cargo
    rustc
    pywal16
    nsxiv
    imagemagick
    colorz
    #env
    devbox

    #hobby
    bambu-studio
    jellyfin-media-player
    spotify
    steam
  ];

  services = {
    dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
        size = "64x64";
      };
      settings = {
        global = {
          follow = "mouse";
        };

        fullscreen = {
          fullscreen = "show";
        };

        alert = {
          summary = "*";
          script = "/home/${username}/.local/bin/play-notification.sh";
        };
      };
    };
  };

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
