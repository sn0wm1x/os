# https://github.com/numtide/system-manager#defining-the-configuration
{ pkgs, ... }:
{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}
