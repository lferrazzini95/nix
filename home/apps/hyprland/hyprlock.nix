{
  pkgs,
  userTheme,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
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
          dots_size = 0.25;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;
          inner_color = "rgb(FFFFFF)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = 10;
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;
          # This is the corrected position
          # position = "0, -150";
          position = "0, 0"; 
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
