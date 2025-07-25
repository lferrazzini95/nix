{ userTheme, ... }:

if userTheme == "everforest"
then {
  # Everforest Dark Palette
  foreground = "#d3c6aa";
  background = "#2d353b";
  background-alt = "#343f44";
  current_line = "#3c474d";
  selection = "#4b565c";
  comment = "#7f848e";
  red = "#e67e80";
  orange = "#e69875";
  green = "#a7c080";
  aqua = "#83c092";
  blue = "#7fbbb3";
  purple = "#d699b6";
  cyan = "#83c092";
  magenta = "#d699b6";
}
else {
  # Nord Palette (used as the default for "nordic" and others)
  foreground = "#d8dee9";
  background = "#2e3440";
  background-alt = "#3b4252";
  current_line = "#3b4252";
  selection = "#434c5e";
  comment = "#4c566a";
  red = "#bf616a";
  orange = "#d08770";
  green = "#a3be8c";
  aqua = "#88c0d0";
  blue = "#81a1c1";
  purple = "#b48ead";
  cyan = "#88c0d0";
  magenta = "#b48ead";
}
