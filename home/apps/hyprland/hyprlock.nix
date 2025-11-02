{
  pkgs,
  username,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = builtins.readFile /home/${username}/.cache/wal/wal;
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      # The time label, correctly placed at the top
      label = [
        {
          monitor = "";
          text = ''$TIME'';
          color = "rgba(255, 255, 255, 0.9)";
          font_size = 90;
          font_family = "FiraCode Nerd Font Mono";
          halign = "center";
          valign = "center";
          position = "0, 100"; 
        }
      ];

      # The input field, now correctly placed at the bottom
      input-field = [
        {
          size = "300, 50";
          inner_color = "rgba(255, 255, 255, 0.2)";
          font_color = "rgb(255, 255, 255)";
          rounding = 10;
          placeholder_text = "Enter Password...";
          check_color = "rgb(204, 136, 34)";
        }
      ];
    };
  };
}
