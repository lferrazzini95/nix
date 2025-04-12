{
  pkgs,
  username,
  userTheme,
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
        favorite-apps = [
          "brave-browser.desktop"
          "Alacritty.desktop"
        ];
      };
    };
  };
  home.file.".background-image".source = ./ui/${userTheme}.jpg;

  home.stateVersion = "24.05";
  #Manage applications
  imports = [
    ./nvim/default.nix

    # (import ./nvim/default.nix { inherit pkgs userTheme; })
    (import ./git/default.nix { inherit pkgs userTheme; })
    (import ./alacritty/default.nix { inherit pkgs userTheme; })
    (import ./tmux/default.nix { inherit pkgs userTheme; })
    (import ./k9s/default.nix { inherit pkgs userTheme; })
  ];
  home.packages = with pkgs; [
    atool
    httpie

    #programming
    go
    dart

    #hobby
    bambu-studio
    jellyfin-media-player
    spotify
  ];

  programs = {
    home-manager.enable = true;
    bash.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
