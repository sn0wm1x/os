{ inputs, outputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
  ];

  # catppuccin/nix
  # https://nix.catppuccin.com/options/nixos-options.html
  catppuccin = {
    flavor = "frappe";
    accent = "blue";
  };

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    sharedModules = [
      inputs.catppuccin.homeModules.catppuccin
      inputs.impermanence.nixosModules.home-manager.impermanence
    ];
    users.kwa.imports = [ ../../home/kwa ];
  };
}
