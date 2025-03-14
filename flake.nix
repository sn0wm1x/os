{
  description = "github:sn0wm1x/os";

  inputs = {
    # agenix.url = "github:ryantm/agenix";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";
    # agenix.inputs.home-manager.follows = "home-manager";
    # # agenix.inputs.systems.follows = "systems";
    # agenix.inputs.darwin.follows = "";
    # agenix-rekey.url = "github:oddlama/agenix-rekey";
    # agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nix-community/browser-previews/pull/27
    # browser-previews.url = "github:nix-community/browser-previews";
    # browser-previews.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # chaotic.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # gnome-mobile.url = "github:chuangzhu/nixpkgs-gnome-mobile";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    # https://github.com/linyinfeng/mobile-nixos
    mobile-nixos.url = "github:linyinfeng/mobile-nixos/development";
    mobile-nixos.flake = false;

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    # nur.url = "github:nix-community/NUR";

    sn0wm1x.url = "github:sn0wm1x/ur";
    sn0wm1x.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      impermanence,
      home-manager,
      ...
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
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations =
        let
          specialArgs = {
            inherit inputs outputs;
          };
        in
        {
          # ./hosts/akahitoha/README.md
          akahitoha = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [ ./hosts/akahitoha ];
          };

          # ./hosts/bluestar/README.md
          bluestar = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [ ./hosts/bluestar ];
          };

          # ./hosts/enchilada/README.md
          enchilada = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";
            modules = [ ./hosts/enchilada ];
          };
        };
    };
}
