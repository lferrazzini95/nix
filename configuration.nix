{
  pkgs,
  host,
  username,
  ...
}: {
  imports = [
    ./hosts/${host}/hardware-configuration.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "iwlwifi.bt_coex_active=0"
      "iwlwifi.swcrypto=1"
      "iwlwifi.power_save=0"
      "iwlwifi.d0i3_disable=0"
      "iwlwifi.uapsd_disable=0"
      "iwlmvm.power_scheme=1"
    ];
  };

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

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
      enable32Bit = true;
    };
  };

  # Services
  services = {
    # displayManager.defaultSession = "hyprland";
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "intl";
      };
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      videoDrivers = ["intel"];
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
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
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        # You can also set energy performance policies
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      };
    };
    power-profiles-daemon.enable = false;
  };

  # Users
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
      #  thunderbird
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
  environment.systemPackages = with pkgs; [
    xclip
    gnugrep
    ripgrep
    unzip
    # android-studio
  ];
  # programs = {
  #   hyprland = {
  #     enable = true;
  #     xwayland.enable = true;
  #   };
  # };

  # Virtualization
  virtualisation.docker.enable = true;

  # System & Nix Settings
  systemd.targets = {
    # hybernate.enable = false;
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11"; # Did you read the comment?
}
