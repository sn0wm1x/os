{ inputs, outputs, ... }:
{
  imports = [
    ../shared
    ../shared/features/desktop/gnome
    ../shared/features/virtualisation
    # inputs.chaotic.nixosModules.default
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./services.nix
    outputs.nixosModules.baseline
    outputs.nixosModules.baseline-desktop
    outputs.nixosModules.impermanence
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "akahitoha";
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # mDNS
  services.resolved.enable = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;

  sn0wm1x.baseline.enable = true;
  sn0wm1x.baseline-desktop.enable = true;
  sn0wm1x.impermanence.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
