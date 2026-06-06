{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kiri.url = "path:/home/utyujin/Dev/tablet";
    ecc = {
      url = "github:affaan-m/everything-claude-code";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ...}@inputs: {
    nixosConfigurations = {

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/wsl-configuration.nix
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/laptop-configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      laptop-2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/laptop2-configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      kiri = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/kiri-configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

    };
  };
}
