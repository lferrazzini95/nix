{ pkgs, userTheme, lib, ... }:

let
  colors = import ./../../../colors.nix { inherit userTheme; };
in
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    extraConfig =
      # Multi-line string for all the config
      ''
        # --- File-based configuration ---
        ${builtins.readFile ./config/tmux.conf}

        # --- Dynamic configuration ---
        set-option -a terminal-features 'alacritty:RGB'
        set -g status-interval 2
        
        set-option -g status-fg '${colors.fg}'
        set-option -g status-bg '${colors.bg0}'
        
        set-option -g mode-style fg='${colors.purple}',bg='${colors.bgRed}'
        set-option -g status-style fg='${colors.fg}',bg='${colors.bgDim}',default
        
        # ---- Windows ----
        set-window-option -g window-status-style fg='${colors.bg5}',bg='${colors.bg0}'
        set-window-option -g window-status-activity-style 'bg=${colors.bg1},fg=${colors.bg3}'
        set-window-option -g window-status-current-style fg='${colors.fg}',bg='${colors.bgGreen}'
        
        # ---- Pane ----
        set-option -g pane-border-style fg='${colors.bg1}'
        set-option -g pane-active-border-style 'fg=${colors.blue}'
        set-option -g display-panes-active-colour '${colors.blue}'
        set-option -g display-panes-colour '${colors.orange}'
        
        # ---- Command ----
        set-option -g message-style fg='${colors.statusline3}',bg='${colors.bgDim}'
        set-option -g message-command-style 'fg=${colors.bg3},bg=${colors.bg1}'
        
        # ---- Miscellaneous ----
        set-window-option -g clock-mode-colour '${colors.blue}'
        set-window-option -g window-status-bell-style fg='${colors.bg0}',bg='${colors.statusline3}'
        
        # ---- Formatting ----
        set-option -g status-left-style none
        set -g status-left-length 60
        set -g status-left '#[fg=${colors.bgDim},bg=${colors.selection},bold] #S #[fg=${colors.selection},bg=${colors.bg5},nobold]#[fg=${colors.selection},bg=${colors.bg2},bold] #(whoami) #[fg=${colors.bg2},bg=${colors.bg0},nobold]'
        
        set-option -g status-right-style none
        set -g status-right-length 150
        set -g status-right '#[fg=${colors.bg2}]#[fg=${colors.fg},bg=${colors.bg2}] #[fg=${colors.fg},bg=${colors.bg2}]%Y-%m-%d  %H:%M #[fg=${colors.aqua},bg=${colors.bg2},bold]#[fg=${colors.bgDim},bg=${colors.aqua},bold] #h '
        
        set -g window-status-separator '#[fg=${colors.grey2},bg=${colors.bg0}] '
        set -g window-status-format '#[fg=${colors.grey0},bg=${colors.bg0}] #I  #[fg=${colors.grey0},bg=${colors.bg0}]#W '
        set -g window-status-current-format '#[fg=${colors.bg0},bg=${colors.statusline1}]#[fg=${colors.bg5},bg=${colors.statusline1}] #I  #[fg=${colors.bg5},bg=${colors.statusline1},bold]#W #[fg=${colors.statusline1},bg=${colors.bg0},nobold]'
      '';
  };
}
