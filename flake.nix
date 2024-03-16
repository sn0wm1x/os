{
  description = "github:kwaa/nixos";

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

    # https://github.com/nix-community/nix-index-database
    # required by https://github.com/nix-community/comma
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/hercules-ci/flake-parts#migrate
    # flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, nix-index-database, impermanence, home-manager, ... }: {
    # nixos-rebuild switch --flake .#bluestar
    nixosConfigurations.bluestar = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/bluestar
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [impermanence.nixosModules.home-manager.impermanence];
          home-manager.users.kwa = import ./home/kwa;
        }
      ];
    };
  };
}
