{
  pkgs,
  userTheme,
  ...
}: let
  theme =
    if userTheme == "nordic"
    then {
      mainColor = "#88C0D0";
      accentColor = "#2E3440";
    }
    else{
      mainColor = "#A7C080";
      accentColor = "#2F383E";
    };
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      direnv = {
        disabled = false;
        format = "╱ [$loaded / $allowed ]($style)";
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
      kubernetes = {
        disabled = false;
        format = "╱ [$context $symbol $namespace]($style)";
        style = theme.mainColor;
        symbol = "󱃾";
      };
    };
  };
}
