{
  pkgs,
  username,
  lib,
  ...
}: let
in {
  programs = {
    waybar = {
      enable = true;
      # Pass the CSS file content directly
      style = builtins.readFile ./style.css;
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
              # ... other icons ...
            };
            persistent-workspaces = {
              "*" = 5;
            };
          };

          backlight = {
            format = "󰃞 {percent}%";
          };
          pulseaudio = {
            format = "{icon}{volume}% {format_source}";
            format-bluetooth = "{icon}󰂯{volume}% {format_source}";
            format-bluetooth-muted = " 󰂯{icon} {volume}% {format_source}";
            format-muted = "  {volume}%{format_source}";
            format-source = "󰍬{volume}%";
            format-source-muted = "󰍭";
            format-icons = {
              headphone = "";
              # ... other icons ...
              default = ["" "" ""];
            };
          };
          cpu = {
            format = " {usage}%";
            interval = 3;
            states = {
              critical = 90;
            };
          };
          memory = {
            format = " {percentage}%";
            interval = 3;
            states = {
              critical = 90;
            };
          };
          disk = {
            interval = 120;
            format = " {percentage_used}%";
            unit = "GiB";
          };
          network = {
            interface = "wlo1";
            interval = 3;
            format = "NET {ifname}";
            format-wifi = "{essid} 󰖩 ({signalStrength}%)";
            format-ethernet = "{ipaddr}/{cidr}";
            format-disconnected = "NET <span color=\"#7c6f64\">disconnected</span>"; # fallback hardcoded color kept
          };
          "custom/vpn" = {
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
            format = " {capacity}%";
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
  # home.file = {
  #   ".config/waybar/waybar-wal-apply" = {
  #     source = ./../scripts/waybar-wal-apply;
  #     executable = true;
  #   };
  # };
  home.file = {
    "/home/${username}/.config/waybar/style-base.css" = {
      source = ./style.css;
    };
  };
}
