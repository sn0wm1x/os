{ inputs, ... }: {
  # https://github.com/nix-community/nix-index-database#usage-in-nixos
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];
  # https://github.com/nix-community/comma
  programs.nix-index-database.comma.enable = true;
}