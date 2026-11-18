{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-ssd
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.kernelParams = [
    "pcie_aspm.policy=powersupersave"
    # Use xe on the Arc A770 so it can enter runtime D3cold.
    "i915.force_probe=!56a0"
    "xe.force_probe=56a0"
    # DisplayPort polling wakes the GPU on this headless host.
    "drm_kms_helper.poll=0"
  ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", KERNEL=="0000:06:00.0", ATTR{link/l1_aspm}="1"
  '';

  nixpkgs.config.cudaSupport = false;
  nixpkgs.config.rocmSupport = false;

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-compute-runtime ];
  };

  # Intel GPU Tools
  environment.systemPackages = with pkgs; [ intel-gpu-tools ];

  # fix i915 GuC / HuC
  hardware.firmware = with pkgs; [ linux-firmware ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
