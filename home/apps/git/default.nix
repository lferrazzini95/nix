{ pkgs, username, email, userTheme, ... }:
let
in
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    extraConfig = {
      core = {
        editor = "nvim";
      };
      merge = {
        tool = "nvimdiff";
      };
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    }; 
    ignores = [
      "tags"
      "tags.temp"
      "tags.lock"
      ".mypy_cache/"
      ".pytest_cache/"
      "__pycache__/"
      ".*.un~"
      ".nvimlog"
      ".tool-versions"
      "/worktrees/"
      ".envrc"
      ".env"
      ".venv/"
      "/shell.nix"
      "/result"
      ".direnv/"
      ".ropeproject/"
      "/.tup/"
    ];
  };
}
