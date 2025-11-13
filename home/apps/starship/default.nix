{pkgs, ...}: let
in {
  programs.starship = {
    enable = true;
    settings = {
      # use all extensions
      format = "$all";
      add_newline = true;
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = "";
        style = "bold";
        format = "([$read_only]($read_only_style) )[$path]($style) ";
      };

      git_branch = {
        symbol = " ";
        format = "╱[ $symbol$branch ]($style)";
        style = "bold";
        truncation_length = 18;
      };

      git_commit = {
        commit_hash_length = 7;
        tag_symbol = " ";
        tag_disabled = false;
        format = "[ $hash]($style)[($tag) ]($style)";
      };

      git_state = {
        format = ''[\($state( $progress_current/$progress_total) \)]($style)'';
        rebase = "󰃻";
        cherry_pick = "";
        merge = "";
        bisect = "󱁉";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        conflicted = "";
        ahead = ''[''${count}]()'';
        behind = ''[''${count}]()'';
        diverged = ''[''${ahead_count}''${behind_count}]()'';
        staged = "[$count]()";
        style = "bold";
        renamed = "󰑕";
        deleted = "󰆳";
      };

      direnv = {
        disabled = false;
        format = "╱ [$loaded / $allowed ]($style)";
        allowed_msg = "";
        not_allowed_msg = "";
        denied_msg = "";
        loaded_msg = "";
        unloaded_msg = "";
      };
      nix_shell = {
        disabled = false;
        format = "╱ [$symbol $state(\\($name\\)) ]($style)";
        symbol = "";
        style = "bold";
        impure_msg = "[ ](bold)";
        pure_msg = "[ ](bold)";
        unknown_msg = "[ ](dimmed)";
      };
      golang = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };
      kubernetes = {
        disabled = false;
        format = "╱ [$context $symbol $namespace]($style)";
        symbol = "󱃾";
      };
    };
  };
}
