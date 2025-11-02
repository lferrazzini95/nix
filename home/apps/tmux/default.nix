{ pkgs, lib, ... }:
let
# The 'colors' import is removed as it's static and will not work with pywal.
in
{
  programs.tmux = {
    enable = true;
    # Use 'screen-256color' or 'tmux-256color' for best compatibility with features.
    terminal = "screen-256color";
    extraConfig =
      # Multi-line string for all the config
      ''
        # --- File-based configuration ---
        # This static file is still included
        ${builtins.readFile ./config/tmux.conf}

        # --- Minimal Dynamic Configuration (Relies on Pywal-themed terminal) ---
        set-option -a terminal-features 'alacritty:RGB'
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
