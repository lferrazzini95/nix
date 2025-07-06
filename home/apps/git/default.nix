{ pkgs, userTheme, ... }:
let
in
{
  programs.git = {
    enable = true;
    userName = "ferrazzo";
    userEmail = "luca733@gmail.com";
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
