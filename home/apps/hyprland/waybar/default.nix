{
  pkgs,
  userTheme,
  ...
}: let
  accentColor =
    if userTheme == "everforest"
    then "#859966"
    else "#697d97";
  vpnStatusScript = pkgs.writeShellScriptBin "vpn-status" ''
    #!/bin/sh
    # This uses the EXACT same path that the sudo rule allows
    if sudo ${pkgs.wireguard-tools}/bin/wg show | grep -q "latest handshake"; then
      printf '{"text": " VPN", "tooltip": "VPN Connected", "class": "connected"}'
    fi
  '';
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
            format = ''<span color="${accentColor}">BL</span> {percent}%'';
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
            format = ''<span color="${accentColor}">CPU</span> {usage}%'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          temperature = {
            "hwmon-path" = "/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp1_input";
            format = ''<span color="${accentColor}">TEM</span> {temperatureC}°C'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = ''<span color="${accentColor}">MEM</span> {used:0.1f}/{total:0.1f}Gi'';
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = ''<span color="${accentColor}">SSD</span> {percentage_used}%'';
            unit = "GiB";
          };
          network = {
            interface = "wlo1";
            interval = 3;
            format = ''<span color="${accentColor}">NET</span> {ifname}'';
            format-wifi = ''<span color="#d3869b">{essid}</span> 󰖩 ({signalStrength}%) <span color="${accentColor}"></span> {bandwidthUpBytes} <span color="${accentColor}"></span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="#d3869b">{ipaddr}/{cidr}</span> <span color="${accentColor}"></span> {bandwidthUpBytes} <span color="${accentColor}"></span> {bandwidthDownBytes}'';
            format-disconnected = ''<span color="${accentColor}">NET</span> <span color="#7c6f64">disconnected</span>'';
          };
          "custom/vpn" = {
            # TODO: solve this via script
            exec = "${vpnStatusScript}/bin/vpn-status";
            return-type = "json";
            interval = 10;
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = ''<span color="${accentColor}"></span> {capacity}%'';
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
    ".local/share/scripts/vpn-status" = {
      source = ./../scripts/vpn-status;
      executable = true;
    };
  };
}
