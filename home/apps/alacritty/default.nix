{ pkgs, userTheme, ... }:
let
  alacrittyTheme = import ./themes/dynamic-theme.nix {inherit userTheme;} ;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [
          "new-session"
          "-A"
          "-s"
          "main"
        ];
      };
      font = {
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        size = 11.0;
      };

      window = {
        position = {
          x = 100;
          y = 100;
        };
        decorations = "None";
        dynamic_padding = true;
        dimensions = {
          columns = 100;
          lines = 30;
        };
        opacity = 0.8;
      };
      selection = {
        save_to_clipboard = true;
      };

      colors = alacrittyTheme.colors;
    };
  };
}
