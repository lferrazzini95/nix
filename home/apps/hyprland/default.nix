{
  pkgs,
  username,
  userTheme,
  ...
}: {

  imports = [
    (import ./waybar/default.nix {inherit pkgs userTheme;})
  ];
  home.packages = with pkgs; [
    swww
    rofi-wayland
  ];

  wayland.windowManager = {
    hyprland = {
      package = pkgs.hyprland;
      enable = true;
      settings = {
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
          dim_strength = 0;#0.3;
          blur = {
            enabled = false;
          };
        };

        input = {
          kb_layout = "us";
          kb_variant = "alt-intl";
          follow_mouse = 0;
          touchpad = {
            disable_while_typing = true;
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
          "$mainMod, RETURN, exec, alacritty -e tmux new-window"
          "$mainMod, L, exec, systemctl suspend"

          # ALT + Direction move focus
          ''$wm, L, movefocus, r''
          ''$wm, H, movefocus, l''
          ''$wm, K, movefocus, u''
          ''$wm, J, movefocus, d''

          # Close window
          "$mainMod, Q, killactive"
          "$mainMod, F, fullscreen"

          # SUPER + D      ->  Open Rofi application launcher
          "$mainMod, D, exec, rofi -show drun"
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
      xwayland.enable = true;
      # --- Autostart ---

      # --- Basic Settings ---

      # --- Keybindings ---
      # This is the most important part.
    };
  };
}
