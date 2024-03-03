{ config, inputs, lib, pkgs, ... }: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-intel
    common-pc-ssd
  ];

  # boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
  boot.kernelModules = [ "kvm-intel" ];
  # boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # https://nixos.wiki/wiki/Intel_Graphics
  # Intel Corporation DG2 [Arc A770] [8086:56a0]
  boot.kernelParams = [ "i915.force_probe=56a0" ];

  services.xserver.videoDrivers = [ "intel" ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
    intel-vaapi-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
