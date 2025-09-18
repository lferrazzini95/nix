{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    username = "luca";
    userTheme = "everforest"; # everforest or nordic or gargantua
    fullName = "Luca Ferrazzini"; # used for github signing
    email = "luca733@gmail.com";
    host = "laptop";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username host;};
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = import ./home/home.nix {
              inherit pkgs pkgs-stable username fullName userTheme email lib;
            };
            home-manager.backupFileExtension = "backup";
          }
          (import ./configuration.nix {inherit pkgs pkgs-stable host username;})
        ];
      };
    };
  };
}
