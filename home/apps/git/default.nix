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
  };
}
