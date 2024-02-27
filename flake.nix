{
  description = "github.com/kwaa/nixos";

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
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }: {
    # nixos-rebuild switch --flake .#bluestar
    nixosConfigurations.bluestar = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kwa = import ./users/kwa.nix;
        }
      ];
    };
  };
}
