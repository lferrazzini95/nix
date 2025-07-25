{ userTheme, ... }:

if userTheme == "everforest"
then {
  # Everforest Dark Palette
  foreground = "#d3c6aa";
  background = "#2E383C";
  background-alt = "#414B50";
  current_line = "#4F5B58";
  selection = "#A7C080";
  comment = "#DBBC7F";
  black = "#1E2326";
  yellow = "#DBBC7F";
  white = "#D3C6AA";
  grey = "#859289";
  red = "#E67E80";
  orange = "#E69875";
  green = "#A7C080";
  aqua = "#83C092";
  blue = "#7FBBF3";
  purple = "#D699B6";
  cyan = "#7FD0C3";
}
else {
  # Nord Palette (used as the default for "nordic" and others)
  foreground = "#d8dee9";
  background = "#2e3440";
  background-alt = "#3b4252";
  current_line = "#3b4252";
  selection = "#a3be8c";
  comment = "#ebcb8b";
  black = "#475258";
  grey = "#859289";
  yellow = "#ebcb8b";
  white = "#d8dee9";
  red = "#bf616a";
  orange = "#d08770";
  green = "#a3be8c";
  aqua = "#88c0d0";
  blue = "#81a1c1";
  purple = "#b48ead";
  cyan = "#88c0d0";
}
