{
  pkgs,
  username,
  userTheme,
  lib,
  ...
}: let
  colors = import ./../../../../colors.nix {inherit userTheme;};
  waybar-style = builtins.readFile ./style.css;
in {
  programs = {
    waybar = {
      enable = true;
      style =
        lib.strings.replaceStrings [
          "@foreground"
          "@module-background"
          "@workspace-hover"
          "@workspace-active"
          "@workspace-empty"
          "@battery-charging"
          "@battery-plugged"
          "@battery-critical"
          "@audio-muted"
          "@audio-source-muted"
          "@idle-activated"
          "@cpu-critical"
          "@mem-critical"
        ]
        [
          colors.foreground
          colors.bg5
          colors.green
          colors.selection
          colors.grey0
          colors.green
          colors.purple
          colors.red
          colors.grey1
          colors.red
          colors.red
          colors.red
          colors.red
        ]
        waybar-style;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 14;
          spacing = 0;
          modules-left = ["backlight" "pulseaudio" "cpu" "memory" "disk"];
          modules-center = ["hyprland/workspaces"];
          modules-right = ["network" "custom/vpn" "battery" "clock"];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-window-separator = "|";
            format-icons = {
              default = "●";
              active = "";
              empty = "○";
              # default = "󰺕";
              # empty = "";
              # presistent = "󰺕";
              # special = "";
              # urgent = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
            # window-rewrite-default = "󰺕";
            # window-rewrite = {
            #   "class<com.mitchellh.ghostty>" = "󰊠";
            #   "class<google-chrome>" = "";
            #   "class<brave-browser>" = "󰴳";
            #   "class<firefox>" = "󰈹";
            # };
          };
          backlight = {
            format = ''<span color="${colors.selection}">BL</span> {percent}%'';
          };
          pulseaudio = {
            format = ''{volume}% {icon} {format_source}'';
            format-bluetooth = ''󰂯 {volume}% {icon} {format_source}'';
            format-bluetooth-muted = ''󰂯 {volume}% {icon}  {format_source}'';
            format-muted = ''{volume}%  {format_source}'';
            format-source = "{volume}% 󰍬";
            format-source-muted = "󰍭";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
          };
          cpu = {
            format = ''<span color="${colors.selection}">C</span> {usage}%'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = ''<span color="${colors.selection}">M</span> {percentage}%''; #{used:0.1f}/{total:0.1f}Gi'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = ''<span color="${colors.selection}">S</span> {percentage_used}%'';
            unit = "GiB";
          };
          network = {
            interface = "wlo1";
            interval = 3;
            format = ''<span color="${colors.selection}">NET</span> {ifname}'';
            format-wifi = ''<span color="${colors.aqua}">{essid}</span> 󰖩 ({signalStrength}%)''; # <span color="${colors.selection}"></span> {bandwidthUpBytes} <span color="${colors.selection}"></span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="${colors.aqua}">{ipaddr}/{cidr}</span>''; # <span color="${colors.selection}"></span> {bandwidthUpBytes} <span color="${colors.selection}"></span> {bandwidthDownBytes}'';
            format-disconnected = ''<span color="${colors.selection}">NET</span> <span color="#7c6f64">disconnected</span>'';
          };
          "custom/vpn" = {
            # TODO: solve this via script
            exec = "/home/${username}/.local/bin/vpn-status";
            return-type = "json";
            interval = 10;
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = ''<span color="${colors.selection}"></span> {capacity}%'';
          };
          clock = {
            format = "{:%F %R}";
            interval = 60;
          };
        };
      };
      systemd.enable = true;
    };
  };
  home.file = {
    ".local/bin/vpn-status" = {
      source = ./../scripts/vpn-status;
      executable = true;
    };
  };
}
