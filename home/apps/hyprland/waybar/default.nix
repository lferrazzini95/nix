{
  pkgs,
  username,
  userTheme,
  ...
}: let
  colors = import ./../../../../colors.nix {inherit userTheme;};
in {
  programs = {
    waybar = {
      enable = true;
      style =
        if userTheme == "everforest"
        then (builtins.readFile ./everforest-style.css)
        else (builtins.readFile ./nordic-style.css);
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          spacing = 4;
          modules-left = ["hyprland/workspaces" "backlight" "pulseaudio"];
          modules-right = ["temperature" "cpu" "memory" "disk" "network" "custom/vpn" "battery" "clock"];
          "hyprland/workspaces" = {
            format = "<sub>{icon}</sub>{windows}";
            format-window-separator = "|";
            format-icons = {
              # "1" = "";
              # "2" = "";
              # "3" = "󰈹";
              default = "󰺕";
              empty = "";
              presistent = "󰺕";
              special = "";
              urgent = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
            window-rewrite-default = "󰺕";
            window-rewrite = {
              "class<com.mitchellh.ghostty>" = "󰊠";
              "class<google-chrome>" = "";
              "class<brave-browser>" = "󰴳";
              "class<firefox>" = "󰈹";
            };
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
            format = ''<span color="${colors.selection}">CPU</span> {usage}%'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          temperature = {
            "hwmon-path" = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp1_input";
            format = ''<span color="${colors.selection}">TEM</span> {temperatureC}°C'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = ''<span color="${colors.selection}">MEM</span> {used:0.1f}/{total:0.1f}Gi'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = ''<span color="${colors.selection}">SSD</span> {percentage_used}%'';
            unit = "GiB";
          };
          network = {
            interface = "wlo1";
            interval = 3;
            format = ''<span color="${colors.selection}">NET</span> {ifname}'';
            format-wifi = ''<span color="#d3869b">{essid}</span> 󰖩 ({signalStrength}%) <span color="${colors.selection}"></span> {bandwidthUpBytes} <span color="${colors.selection}"></span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="#d3869b">{ipaddr}/{cidr}</span> <span color="${colors.selection}"></span> {bandwidthUpBytes} <span color="${colors.selection}"></span> {bandwidthDownBytes}'';
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
