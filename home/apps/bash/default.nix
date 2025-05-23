{ pkgs, userTheme, ... }:
let
in
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
    };
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      export EDITOR=nvim
    '';
  };
}
