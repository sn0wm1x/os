{
  description = "github:sn0wm1x/os";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # https://github.com/NixOS/nixos-hardware#using-nix-flakes-support
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # https://github.com/nix-community/disko/blob/master/docs/HowTo.md#installing-nixos-module
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nix-community/impermanence#nixos
    impermanence.url = "github:nix-community/impermanence";

    # https://nix-community.github.io/home-manager/#ch-nix-flakes
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/hercules-ci/flake-parts#migrate
    # flake-parts.url = "github:hercules-ci/flake-parts";

    # nur.url = "github:nix-community/NUR";

    sn0wm1x.url = "github:sn0wm1x/ur";
    sn0wm1x.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-substituters = [ "https://sn0wm1x.cachix.org" ];
    extra-trusted-public-keys = [ "sn0wm1x.cachix.org-1:osOGZnIhSALHVbNcjx9pJIcqNCieQp8I5asyf2IPZFc=" ];
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , impermanence
    , home-manager
    , ...
    }:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # ./hosts/akahitoha/README.md
        akahitoha = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/akahitoha ];
        };

        # ./hosts/bluestar/README.md
        bluestar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/bluestar ];
        };
      };
    };
}
