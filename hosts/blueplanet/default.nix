{ inputs, outputs, ... }:
{
  imports = [
    ../shared
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./services.nix
    outputs.nixosModules.default
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.tpm2.enable = true;
  boot.initrd.luks.devices.cryptroot.crypttabExtraOpts = [ "tpm2-device=auto" ];
  security.tpm2.enable = true;

  networking.hostName = "blueplanet";
  # TODO: impala
  # https://github.com/pythops/impala
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  sn0wm1x.baseline.enable = true;
  sn0wm1x.impermanence.enable = true;
  environment.persistence."/persist".files = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_rsa_key.pub"
  ];
  sn0wm1x.virtualisation.docker.enable = true;
  sn0wm1x.virtualisation.libvirt.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
