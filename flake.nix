{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      system = "x86_64-linux";
      userList = [
        {
          username = "root";
          userTheme = "everforest"; # everforest or nordic
          essentialsOnly = true;
        }
        {
          username = "luca";
          userTheme = "everforest"; # everforest or nordic
          essentialsOnly = false;
        }
      ];
      # theme = "everforest"; #everforest or nordic
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.users = pkgs.lib.listToAttrs (
                map (user: {
                  name = user.username;
                  value = import ./home/home.nix {
                    pkgs = pkgs;
                    username = user.username;
                    userTheme = user.userTheme;
                    essentialsOnly = user.essentialsOnly;
                  };
                }) userList
              );
            }
            ./nixos/configuration.nix
          ];
        };
      };
    };
}
