{ pkgs, userTheme, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./config/tmux-${userTheme}.conf;
    # plugins = with pkgs; [
    #   tmuxPlugins.nord
    # ];
  };
}
