{
  pkgs,
  username,
  userTheme,
  essentialsOnly,
  ...
}:
let
  desktopPath = "org/gnome/desktop";
  themePackage =
    if userTheme == "nordic" then
      pkgs.nordic
    else if userTheme == "everforest" then
      pkgs.everforest-gtk-theme
    else
      pkgs.defaultTheme;

  optionalApps = [
    (import ./alacritty/default.nix { inherit pkgs userTheme; })
    (import ./tmux/default.nix { inherit pkgs userTheme; })
  ];
in
{
  #Manage Appearance
  gtk = {
    enable = true;
    theme = {
      package = themePackage;
      name = userTheme;
    };
  };
  dconf = {
    enable = true;
    settings = {
      "${desktopPath}/background" = {
        "picture-uri" = "/home/${username}/.background-image";
        "picture-uri-dark" = "/home/${username}/.background-image";
      };
      "${desktopPath}/screensaver" = {
        "picture-uri" = "/home/${username}/.background-image";
        "picture-uri-dark" = "/home/${username}/.background-image";
      };
      "${desktopPath}/interface" = {
        "color-scheme" = "prefer-dark";
      };
      "org/gnome/shell" = {
        "favourite-apps" = [
          "brave-browser.desktop"
        ];
      };
    };
  };
  home.file.".background-image".source = ./ui/${userTheme}.jpg;

  home.stateVersion = "24.05";
  #Manage applications
  imports = [
    (import ./nvim/default.nix { inherit pkgs userTheme; })
  ] ++ pkgs.lib.optionals (essentialsOnly == false) optionalApps;

  home.packages = [
    pkgs.atool
    pkgs.httpie
    pkgs.jellyfin-media-player
    pkgs.go
  ];

  programs = {
    home-manager.enable = true;
    bash.enable = true;
    git = {
      enable = true;
      userName = "ferrazzo";
      userEmail = "luca733@gmail.com";
    };
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
