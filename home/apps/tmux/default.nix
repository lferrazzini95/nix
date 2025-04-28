{ pkgs, userTheme, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    extraConfig =
      builtins.readFile ./config/tmux-${userTheme}.conf + "\n" + builtins.readFile ./config/tmux.conf;
    # plugins = with pkgs; [
    #   tmuxPlugins.nord
    # ];
  };
}
