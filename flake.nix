{
  description = "Unified Workstation Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      userSettings = if builtins.pathExists ./modules/shared/secrets.nix 
        then import ./modules/shared/secrets.nix 
        else import ./modules/shared/secrets.nix.example;
    in
    {
      darwinConfigurations = {
        "${userSettings.laptopHostname}" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit userSettings; };
          modules = [
            ./modules/darwin/default.nix
            ./modules/darwin/usecase-meet.nix

            home-manager.darwinModules.home-manager
            {
              users.users.${userSettings.username}.home = "/Users/${userSettings.username}";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = { ... }: {
                home.username = userSettings.username;
                home.homeDirectory = "/Users/${userSettings.username}";
                imports = [
                  ./modules/shared/core.nix
                  ./modules/shared/vscode.nix
                ];
              };
              home-manager.extraSpecialArgs = { inherit userSettings; };
            }
          ];
        };

        "${userSettings.studioHostname}" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit userSettings; };
          modules = [
            ./modules/darwin/default.nix
            ./modules/darwin/machine-studio.nix
            ./modules/darwin/usecase-develop.nix

            home-manager.darwinModules.home-manager
            {
              users.users.${userSettings.username}.home = "/Users/${userSettings.username}";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = { ... }: {
                home.homeDirectory = "/Users/${userSettings.username}";
                imports = [
                  ./modules/shared/core.nix
                  ./modules/shared/vscode.nix
                ];
              };
              home-manager.extraSpecialArgs = { inherit userSettings; };
            }
          ];
        };
      };

      homeConfigurations."localhost" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        extraSpecialArgs = { inherit userSettings; };
        modules = [
          ./modules/shared/core.nix 
          ./modules/shared/vscode.nix
          ./modules/linux/home.nix
          ./modules/linux/usecase-develop.nix
        ];
      };
    };
}