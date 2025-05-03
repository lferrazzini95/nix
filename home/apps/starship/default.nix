{ pkgs, userTheme, ... }:
let
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };
}
