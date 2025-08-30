{
  pkgs,
  username,
  userTheme,
  ...
}: let
  colors = import ./../../../colors.nix {inherit userTheme;};
in {
  imports = [
    (import ./waybar/default.nix {inherit pkgs username userTheme;})
    (import ./hyprlock.nix {inherit pkgs userTheme;})
    (import ./hypridle.nix {inherit pkgs userTheme;})
  ];

  home.packages = with pkgs; [
    swww
    rofi-wayland
  ];

  home.file = {
    ".local/bin/rofi-wifi-menu" = {
      source = ./scripts/rofi-wifi-menu;
      executable = true;
    };
    ".local/bin/power-menu" = {
      source = ./scripts/power-menu;
      executable = true;
    };
    ".local/bin/rofi-bluetooth" = {
      source = ./scripts/rofi-bluetooth;
      executable = true;
    };
    ".local/bin/vpn-selector" = {
      source = ./scripts/vpn-selector;
      executable = true;
    };
    ".local/bin/change-brightness" = {
      source = ./scripts/change-brightness;
      executable = true;
    };
    ".local/bin/screenshot" = {
      source = ./scripts/screenshot;
      executable = true;
    };
  };

  wayland.windowManager = {
    hyprland = {
      package = pkgs.hyprland;
      enable = true;
      settings = {
        monitor = [
          ''eDP-1, 2880x1800@60, 0x0,2''
          # ",highres,auto,2"
        ];

        "$mainMod" = "SUPER";
        "$term" = "alacritty";
        "$general" = "SUPER";
        "$wm" = "ALT";
        "$app" = "CONTROL";

        exec-once = [
          "${pkgs.dunst}/bin/dunst"
          "${pkgs.swww}/bin/swww-daemon"
          "${pkgs.swww}/bin/swww img /home/${username}/.background-image"
          "${pkgs.hyprland}/bin/hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 24"
        ];

        env = [
          ''XDG_SESSION_TYPE,wayland''
        ];

        general = {
          border_size = 2;
          gaps_in = 0;
          gaps_out = 0;
          "col.active_border" = "rgb(${builtins.substring 1 7 colors.aqua})";
          layout = "dwindle";
        };
        decoration = {
          rounding = 3;
          shadow = {
            enabled = false;
          };
          dim_inactive = true;
          dim_strength = 0; #0.3;
          blur = {
            enabled = false;
          };
        };

        input = {
          kb_layout = "us";
          kb_variant = "alt-intl";
          follow_mouse = 0;
          touchpad = {
            disable_while_typing = false;
            natural_scroll = true;
          };
        };
        misc = {
          vfr = true;
          focus_on_activate = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        bind = [
          #====Basic Commands====#
          # open terminal
          "$mainMod, RETURN, exec, alacritty"

          # lock screen
          "$mainMod, L, exec, hyprlock"

          # custom bindings
          "$mainMod, V, exec, /home/${username}/.local/bin/vpn-selector"
          "$mainMod, B, exec, /home/${username}/.local/bin/rofi-bluetooth"
          "$mainMod, W, exec, /home/${username}/.local/bin/rofi-wifi-menu"
          "$mainMod, S, exec, /home/${username}/.local/bin/screenshot"
          "$mainMod, P, exec, /home/${username}/.local/bin/power-menu"

          # ALT + Direction move focus
          ''$wm, L, movefocus, r''
          ''$wm, H, movefocus, l''
          ''$wm, K, movefocus, u''
          ''$wm, J, movefocus, d''

          # Close window
          "$mainMod, Q, killactive"
          "$mainMod, F, fullscreen"

          # SUPER + D      ->  Open Rofi application launcher
          "$mainMod, D, exec, rofi -show drun -show-icons"

          #====Workspaces====#
          # move to workspace X
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"

          # move window to workspace X
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"

          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

          # "$mainMod SHIFT, K, movetoworkspace, e+1"
          # "$mainMod SHIFT, J, movetoworkspace, e-1"

          # "$mainMod, S, movetoworkspace, special"
          "$mainMod SHIFT, S, togglespecialworkspace"
        ];

        bindle = [
          '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+''
          '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-''
          # '', XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 1%-''
          # '', XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +1%''
          '', XF86MonBrightnessDown, exec, /home/${username}/.local/bin/change-brightness down''
          '', XF86MonBrightnessUp,   exec, /home/${username}/.local/bin/change-brightness up''
        ];
      };

      systemd.enable = true;
      xwayland = {
        enable = true;
      };
      # extraConfig = ''
      #   xwayland {
      #     force_zero_scaling = true
      #   }
      # '';
      # --- Autostart ---

      # --- Basic Settings ---

      # --- Keybindings ---
      # This is the most important part.
    };
  };
}
