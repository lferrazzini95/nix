{
  pkgs,
  pkgs-stable,
  username,
  email,
  userTheme,
  lib,
  ...
}: let
  themePackage =
    if userTheme == "nordic"
    then {
      gtkPackage = pkgs.nordic;
      gtkPackageName = "Nordic";
      iconPackage = pkgs.papirus-icon-theme;
      iconPackageName = "Papirus-Dark";
      cursorPackage = pkgs.capitaine-cursors-themed;
      cursorPackageName = "Capitaine Cursors (Gruvbox)";
    }
    else if userTheme == "everforest"
    then {
      gtkPackage = pkgs.everforest-gtk-theme;
      gtkPackageName = "Everforest-Dark-BL";
      iconPackage = pkgs.papirus-icon-theme;
      iconPackageName = "Papirus-Dark";
      cursorPackage = pkgs.capitaine-cursors-themed;
      cursorPackageName = "Capitaine Cursors (Gruvbox)";
    }
    else if userTheme == "gargantua"
    then {
      gtkPackage = pkgs.adwaita-qt;
      gtkPackageName = "Adwaita-dark";
      iconPackage = pkgs.papirus-icon-theme;
      iconPackageName = "Papirus-Dark";
      cursorPackage = pkgs.capitaine-cursors-themed;
      cursorPackageName = "Capitaine Cursors (Adwaita)";
    }
    else pkgs.defaultTheme;
  colors = import ./../colors.nix {inherit userTheme;};
in {
  home.stateVersion = "24.05";

  imports = [
    (import ./apps/nvim/default.nix {inherit pkgs pkgs-stable userTheme;})
    (import ./apps/git/default.nix {inherit pkgs username email userTheme;})
    (import ./apps/alacritty/default.nix {inherit pkgs userTheme;})
    (import ./apps/tmux/default.nix {inherit pkgs userTheme lib;})
    (import ./apps/k9s/default.nix {inherit pkgs userTheme;})
    (import ./apps/bash/default.nix {inherit pkgs userTheme;})
    (import ./apps/gpg/default.nix {inherit pkgs;})
    (import ./apps/starship/default.nix {inherit pkgs userTheme;})
    (import ./apps/rofi/default.nix {inherit pkgs username userTheme;})
    (import ./apps/hyprland/default.nix {inherit pkgs username userTheme lib;})
  ];

  #Manage Appearance
  gtk = {
    enable = true;
    theme = {
      package = themePackage.gtkPackage;
      name = themePackage.gtkPackageName;
    };
    iconTheme = {
      package = themePackage.iconPackage;
      name = themePackage.iconPackageName;
    };
    cursorTheme = {
      package = themePackage.cursorPackage;
      name = themePackage.cursorPackageName;
      size = 32;
    };
  };

  home.file = {
    ".background-image".source = ./ui/${userTheme}.jpg;
    ".local/bin/opf" = {
      source = ./scripts/opf;
      executable = true;
    };
    ".local/bin/hf" = {
      source = ./scripts/hf;
      executable = true;
    };
    ".local/bin/tn" = {
      source = ./scripts/tn;
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
    cargo
    cargo-nextest
    rustc

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

        urgency_low = {
          frame_color = colors.selection;
          foreground = colors.foreground;
          background = colors.background;
          timeout = 2;
        };

        urgency_normal = {
          frame_color = colors.yellow;
          foreground = colors.foreground;
          background = colors.background;
          timeout = 5;
        };

        urgency_critical = {
          frame_color = colors.red;
          foreground = colors.foreground;
          background = colors.background;
          timeout = 0;
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
