{ pkgs, lib, ... }:
let
# The 'colors' import is removed as it's static and will not work with pywal.
in
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig =
      ''
        # --- File-based configuration ---
        ${builtins.readFile ./config/tmux.conf}

        # --- Minimal Dynamic Configuration ---
        # set-option -a terminal-features 'screen-256color-bce'
        # set-option -a terminal-features 'alacritty:RGB'
        # set -g status-interval 2
        
        # ---- Status Left (Requires explicit codes for Powerline separators) ----
        set -g status-left-length 60
        # Replaced custom color variables with ANSI codes (e.g., 'selection' -> colour4)
        set -g status-left '#[bold] #S #[nobold]  #[bold] #(whoami) #[nobold]  '

        # ---- Status Right (Requires explicit codes for Powerline separators) ----
        set -g status-right-length 150
        set -g status-right '%Y-%m-%d  %H:%M  #h '
      '';
  };
}
