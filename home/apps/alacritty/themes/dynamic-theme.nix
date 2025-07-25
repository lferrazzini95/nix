{
  userTheme,
  ...
}: let
  colors = import ./../../../../colors.nix {inherit userTheme;};
in {
  colors = {
    primary = {
      background = colors.background;
      foreground = colors.foreground;
    };

    vi_mode_cursor = {
      text = colors.background-alt;
      cursor = colors.selection;
    };

    selection = {
      text = "CellForeground";
      background = colors.background-alt;
    };

    search = {
      matches = {
        foreground = "CellBackground";
        background = colors.background-alt;
      };
      focused_match = {
        background = colors.background-alt;
        foreground = colors.selection;
      };
    };
    normal = {
      black = colors.black;
      red = colors.red;
      green = colors.green;
      yellow = colors.yellow;
      blue = colors.blue;
      cyan = colors.cyan;
      white = colors.white;
    };

    bright = {
      black = colors.black;
      red = colors.red;
      green = colors.green;
      yellow = colors.yellow;
      blue = colors.blue;
      cyan = colors.cyan;
      white = colors.white;
    };
  };
}
