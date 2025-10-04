{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    # CPPC is now enabled since NLCN30WW
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop
    common-pc-ssd
    common-hidpi
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [
    # https://nixos.wiki/wiki/AMD_GPU#Make_the_kernel_use_the_correct_driver_early
    "amdgpu"
    # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
    "uas"
    "usbcore"
    "usb_storage"
    "vfat"
    "exfat"
    "nls_cp437"
    "nls_iso8859_1"
    # microSD
    "sd_mod"
    "mmc_core"
    "mmc_block"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_16#Fix_Color_accuracy_in_Power_Saving_modes
  boot.kernelParams = [ "amdgpu.abmlevel=0" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  # conflict with services.tuned
  services.tlp.enable = false;
  services.tuned.enable = true;
  services.auto-epp.enable = true;
  powerManagement.enable = true;

  # install linux-firmware
  hardware.firmware = with pkgs; [ linux-firmware ];

  hardware.graphics.enable = true;
  # https://nixos.wiki/wiki/AMD_GPU#Vulkan
  hardware.graphics.enable32Bit = true;
  # https://nixos.wiki/wiki/AMD_GPU#OpenCL
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  # ambient light sensor
  hardware.sensor.iio.enable = true;

  # ROCm Support
  nixpkgs.config.cudaSupport = false;
  nixpkgs.config.rocmSupport = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
