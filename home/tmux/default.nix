{ pkgs, userTheme, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color:Tc";
    extraConfig = builtins.readFile ./config/tmux-${userTheme}.conf;
    # plugins = with pkgs; [
    #   tmuxPlugins.nord
    # ];
  };
}
