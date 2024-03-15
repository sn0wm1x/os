{ pkgs, ... }: {
  environments.systemPackages = with pkgs; [
    comma # https://github.com/nix-community/comma
  ];
}