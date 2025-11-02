{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.85; # Adjust this value to your liking
      
      dynamic_background_opacity = true;
      
      # Optional: Add blur to the background
      # background_blur = 5; 
    };
    extraConfig = ''
      golbalinclude /home/luca/.cache/wal/colors-kitty.conf;
      kitty @ set-colors --all /home/luca/.cache/wal/colors-kitty.conf
    '';
  };
}
