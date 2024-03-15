{ pkgs, ... }: {
  # TODO: https://github.com/nix-community/nix-index-database
  environment.systemPackages = with pkgs; [
    comma # https://github.com/nix-community/comma
  ];
}