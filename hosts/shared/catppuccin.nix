{ inputs, ... }: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # https://nix.catppuccin.com/options/nixos-options.html
  catppuccin.flavor = "frappe";
  catppuccin.accent = "blue";
}
