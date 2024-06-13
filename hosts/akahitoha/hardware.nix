{ config
, inputs
, lib
, pkgs
, ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    # common-cpu-amd-raphael-igpu # TODO: try this
    common-gpu-amd
    common-pc-laptop
    common-pc-ssd
    common-hidpi
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  # use linux 6.10+ testing kernel
  boot.kernelPackages = pkgs.linuxPackages_testing;

  # TODO: other hardware config

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
