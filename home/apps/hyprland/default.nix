{
  pkgs,
  username,
  userTheme,
  ...
}: let
  vpnToggleScript = pkgs.writeShellScriptBin "vpn-toggle" ''
    #!/bin/sh
    # Check if the wg0 interface exists and is "up"
    if ip link show wg0 up > /dev/null; then
      # If it's up, bring it down
      gksudo ${pkgs.wireguard-tools}/bin/wg-quick down wg0
    else
      # If it's down, bring it up
      gksudo ${pkgs.wireguard-tools}/bin/wg-quick up wg0
    fi
  '';
in {
  imports = [
    (import ./waybar/default.nix {inherit pkgs userTheme;})
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
    ".local/bin/rofi-bluetooth" = {
      source = ./scripts/rofi-bluetooth;
      executable = true;
    };
  };

  wayland.windowManager = {
    hyprland = {
      package = pkgs.hyprland;
      enable = true;
      settings = {
        monitor = [
          # ''eDP-1, 2880x1800@60, 0x0,2''
          ",highres,auto,2"
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
          # ''GTK_THEME,Materia-dark''
          ''GDK_SCALE=2''
          ''QT_SCALE_FACTOR=2'' # For all Qt apps
          # ''GDK_DPI_SCALE=0.1''
          ''XDG_SESSION_TYPE,wayland''
        ];

        general = {
          border_size = 2;
          gaps_in = 0;
          gaps_out = 0;
          "col.active_border" = "rgb(83C092)";
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
          # SUPER + ENTER  ->  Open Kitty terminal
          "$mainMod, RETURN, exec, alacritty"
          "$mainMod, L, exec, systemctl suspend"

          "$mainMod, V, exec, ${vpnToggleScript}/bin/vpn-toggle"

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
          "$mainMod, B, exec, rofi-bluetooth"
          "$mainMod, W, exec, rofi-wifi-menu"

          # Workspaces
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"

          "mainMod SHIFT, K, movetoworkspace, e+1"
          "$mainMod SHIFT, J, movetoworkspace, e-1"

          "$mainMod, S, movetoworkspace, special"
          "$mainMod SHIFT, S, togglespecialworkspace"
        ];

        bindle = [
          '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+''
          '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-''
          '', XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s 1%-''
          '', XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c 'backlight' -d '*backlight*' s +1%''
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
