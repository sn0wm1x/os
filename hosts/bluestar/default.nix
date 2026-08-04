{
  inputs,
  outputs,
  lib,
  ...
}:
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
    outputs.nixosModules.gaming
    outputs.nixosModules.impermanence
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Preserve evidence from kernel lockups and reboot automatically.
  # EFI pstore keeps the tail of the kernel log across the reboot, while the
  # hardware watchdog is a final fallback if the kernel cannot panic cleanly.
  boot.kernelParams = [ "nmi_watchdog=1" ];
  boot.kernelModules = [ "iTCO_wdt" ];
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = lib.mkForce 1;
    "kernel.watchdog_thresh" = 10;
    "kernel.hardlockup_panic" = 1;
    "kernel.softlockup_panic" = 1;
    "kernel.panic_on_oops" = 1;
    "kernel.panic" = 15;
  };

  systemd.settings.Manager = {
    RuntimeWatchdogSec = "30s";
    RebootWatchdogSec = "2min";
  };

  environment.etc."systemd/pstore.conf".text = ''
    [PStore]
    Storage=external
    Unlink=yes
  '';

  hardware.rasdaemon.enable = true;

  # This host uses an ephemeral root, so archived panic and RAS records must
  # live on the persistent filesystem to survive the next boot.
  environment.persistence."/persist".directories = [
    "/var/lib/systemd/pstore"
    "/var/lib/rasdaemon"
  ];

  networking.hostName = "bluestar";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  sn0wm1x.baseline.enable = true;
  sn0wm1x.baseline-desktop.enable = true;
  sn0wm1x.gaming.enable = true;
  sn0wm1x.impermanence.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
