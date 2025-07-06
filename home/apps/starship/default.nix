{ pkgs, userTheme, ... }:
let
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
       direnv = {
        disabled = false;
        format = "╱ [$loaded/$allowed ]($style)";
        allowed_msg = "";
        not_allowed_msg = "";
        denied_msg = "";
        loaded_msg = "";
        unloaded_msg = "";
      };
      golang = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };
    };
  };
}
