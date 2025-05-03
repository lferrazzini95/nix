{ pkgs, ... }:
let
in
{
  programs.gpg = {
    enable = true;
  };
}
