{
  pkgs,
  username,
  userTheme,
  ...
}: {
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
          "${pkgs.swww}/bin/swww-daemon"
          "${pkgs.swww}/bin/swww img /home/${username}/.background-image"
          "${pkgs.hyprland}/bin/hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 24"
        ];

        env = [
          # ''GTK_THEME,Materia-dark''
          ''XDG_SESSION_TYPE,wayland''
        ];

        input = {
          kb_layout = "us";
          kb_variant = "alt-intl";
          follow_mouse = 0;
          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
          };
        };
        general = {
          border_size = 2;
          gaps_in = 0;
          gaps_out = 0;
          "col.active_border" = "rgb(83C092)";
          layout = "dwindle";
        };
        misc = {
          vfr = true;
          focus_on_activate = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        decoration = {
          rounding = 3;
          shadow = {
            enabled = false;
          };
          dim_inactive = true;
          dim_strength = 0.3;
          blur = {
            enabled = false;
          };
        };
        bind = [
          # SUPER + ENTER  ->  Open Kitty terminal
          "$mainMod, RETURN, exec, alacritty"
          "$mainMod, L, exec, systemctl suspend"

          # ALT + Direction move focus
          ''$wm, L, movefocus, r''
          ''$wm, H, movefocus, l''
          ''$wm, K, movefocus, u''
          ''$wm, J, movefocus, d''
          # SUPER + Q      ->  Close the active window
          "$mainMod, Q, killactive,"

          # SUPER + D      ->  Open Rofi application launcher
          "$mainMod, D, exec, rofi -show drun"
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
