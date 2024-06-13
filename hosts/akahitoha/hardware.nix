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
  # https://nixos.wiki/wiki/AMD_GPU#Make_the_kernel_use_the_correct_driver_early
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  # use linux 6.10+ testing kernel
  boot.kernelPackages = pkgs.linuxPackages_testing;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # install linux-firmware and sof-firmware
  hardware.firmware = with pkgs; [ linux-firmware ];

  hardware.opengl.enable = true;
  # https://nixos.wiki/wiki/AMD_GPU#Vulkan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    # https://nixos.wiki/wiki/AMD_GPU#OpenCL
    rocmPackages.clr.icd
    # https://nixos.wiki/wiki/AMD_GPU#AMDVLK
    amdvlk
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
