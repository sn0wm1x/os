{ inputs, outputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
  home-manager.sharedModules = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
  home-manager.users.kwa.imports = [
    ../../home/kwa
  ];
}
