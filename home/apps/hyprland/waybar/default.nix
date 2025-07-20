{
  pkgs,
  userTheme,
  ...
}: let
  accentColor = 
    if userTheme == "everforest"
    then "#859966"
    else "#697d97";
in {
  programs = {
    waybar = {
      enable = true;
      style = (builtins.readFile ./everforest-style.css);
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          spacing = 4;
          modules-left = ["hyprland/workspaces" "backlight" "idle_inhibitor" "pulseaudio"];
          modules-right = ["cpu" "memory" "disk" "network" "custom/vpn" "battery" "clock"];
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
          idle_inhibitor = {
            format = ''<span color="${accentColor}">IDL</span> {icon}'';
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          pulseaudio = {
            format = ''<span color="${accentColor}">VOL</span> {volume}% {icon} {format_source}'';
            format-bluetooth = ''<span color="${accentColor}">VOL</span> 󰂯 {volume}% {icon} {format_source}'';
            format-bluetooth-muted = ''<span color="${accentColor}">VOL</span> 󰂯 {volume}% {icon}  {format_source}'';
            format-muted = ''<span color="${accentColor}">VOL</span> {volume}%  {format_source}'';
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
            format-wifi = ''<span color="#d3869b">{essid}</span> 󰖩 ({signalStrength}%) <span color="${accentColor}">UP</span> {bandwidthUpBytes} <span color="${accentColor}">DN</span> {bandwidthDownBytes}'';
            format-ethernet = ''<span color="#d3869b">{ipaddr}/{cidr}</span> <span color="${accentColor}">UP</span> {bandwidthUpBytes} <span color="${accentColor}">DN</span> {bandwidthDownBytes}'';
            format-disconnected = ''<span color="${accentColor}">NET</span> <span color="#7c6f64">disconnected</span>'';
          };
          "custom/vpn" = {
            exec = "${pkgs.luajit}/bin/luajit ~/.local/share/scripts/vpn.lua";
            exec-if = ''systemctl is-active "openvpn-*"'';
            interval = 60;
            format = ''<span color="${accentColor}">VPN</span> {}'';
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = ''<span color="${accentColor}">BAT</span> {capacity}%'';
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
  # home.file = {
  #   ".local/share/scripts/vpn.lua" = {
  #     source = ./../scripts/vpn.lua;
  #   };
  # };
}
