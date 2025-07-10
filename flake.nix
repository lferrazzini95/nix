{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    username = "luca";
    userTheme = "everforest"; # everforest or nordic
    host = "laptop";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = import ./home/home.nix {
              inherit pkgs username userTheme;
            };
          }
          (import ./configuration.nix {inherit pkgs host username;})
        ];
      };
    };
  };
}
