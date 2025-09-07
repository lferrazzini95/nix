{
  pkgs,
  pkgs-stable,
  host,
  username,
  ...
}: {
  imports = [
    ./hosts/${host}/hardware-configuration.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Networking
  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
      rejectPackets = true;
      allowedTCPPorts = [];
    };
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    wireguard.interfaces = {
      wg0 = {
        ips = ["10.0.0.4/32"];
        listenPort = 51280;
        privateKeyFile = "/etc/wireguard/private.key";
        peers = [
          {
            publicKey = builtins.readFile /etc/wireguard/serverPublic.key;
            # Only specific traffic should be routed
            allowedIPs = ["10.0.0.1/32" "10.43.0.10/32" "192.168.1.225/32"];
            endpoint = builtins.readFile /etc/wireguard/serverEndpoint.txt;
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  # required to steer vpn connection through hyrpland binding
  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl start wireguard-wg0.service";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/systemctl stop wireguard-wg0.service";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Time & Localization
  time.timeZone = "Europe/Rome";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [intel-media-driver intel-vaapi-driver libvdpau-va-gl];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {General = {Enable = "Source,Sink,Media,Socket";};};
    };
  };

  # Services
  services = {
    displayManager.gdm.enable = true;
    xserver = {
      videoDrivers = ["intel"];
    };
    syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
    pipewire = {
      enable = true;
      package = pkgs-stable.pipewire;
      wireplumber = {
        package = pkgs-stable.wireplumber;
      };
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_DRIVER_ON_AC = "intel_pstate";
        CPU_SCALING_DRIVER_ON_BAT = "intel_pstate";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      };
    };
    power-profiles-daemon.enable = false;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
    ];
    packages = with pkgs; [
    ];
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.sauce-code-pro
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono"];
        sansSerif = ["FiraCode Nerd Font"];
      };
    };
  };

  # Packages & Environment
  environment = {
    systemPackages = with pkgs; [
      xclip
      htop
      gnugrep
      ripgrep
      unzip
      glib
      wireguard-tools
      brightnessctl
      rofi
      libnotify
      gemini-cli
      syncthing
      # android-studio
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [username];
    };
    _1password.enable = true;
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };

  # Virtualization
  virtualisation.docker.enable = true;

  # System & Nix Settings
  # systemd.targets = {
  #   suspend.enable = false;
  #   hybernate.enable = false;
  #   hybrid-sleep.enable = false;
  # };
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11"; # Did you read the comment?
}
