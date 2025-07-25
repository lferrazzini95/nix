{
  pkgs,
  username,
  userTheme,
  ...
}: let
  colors = import ./../../../colors.nix {inherit userTheme;};
in {
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "rofi-theme";
    package = pkgs.rofi-wayland;
  };

  home.file = {
    ".local/share/rofi/themes/rofi-theme.rasi" = {
      source = ./themes/rofi-theme.rasi;
    };
    ".local/share/rofi/themes/shared/colors.rasi" = {
      text = ''
        * {
            background:     ${colors.background}FF;
            background-alt: ${colors.background-alt}FF;
            foreground:     ${colors.foreground}FF;
            selected:       ${colors.aqua}FF;
            active:         ${colors.green}FF;
            urgent:         ${colors.red}FF;
        }
      '';
    };
    ".local/share/rofi/themes/shared/fonts.rasi" = {
      source = ./themes/shared/fonts.rasi;
    };
  };
}
