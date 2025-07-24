{
  pkgs,
  username,
  email,
  userTheme,
  ...
}: let
  themePackage =
    if userTheme == "nordic"
    then {
      package = pkgs.nordic;
      name = "Nordic";
    }
    else if userTheme == "everforest"
    then {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Dark-BL";
    }
    else pkgs.defaultTheme;
in {
  #Manage Appearance
  gtk = {
    enable = true;
    theme = {
      package = themePackage.package;
      name = themePackage.name;
    };
  };

  home.stateVersion = "24.05";

  imports = [
    (import ./apps/nvim/default.nix {inherit pkgs userTheme;})
    (import ./apps/git/default.nix {inherit pkgs username email userTheme;})
    (import ./apps/alacritty/default.nix {inherit pkgs userTheme;})
    (import ./apps/tmux/default.nix {inherit pkgs userTheme;})
    (import ./apps/k9s/default.nix {inherit pkgs userTheme;})
    (import ./apps/bash/default.nix {inherit pkgs userTheme;})
    (import ./apps/gpg/default.nix {inherit pkgs;})
    (import ./apps/starship/default.nix {inherit pkgs userTheme;})
    (import ./apps/hyprland/default.nix {inherit pkgs username userTheme;})
  ];

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

    #env
    devbox

    #hobby
    bambu-studio
    jellyfin-media-player
    spotify
    steam
    ardour
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
          frame_color = "#1D918B";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 2;
        };

        urgency_normal = {
          frame_color = "#D16BB7";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 5;
        };

        urgency_critical = {
          frame_color = "#FC2929";
          foreground = "#FFFF00";
          background = "#18191E";
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
