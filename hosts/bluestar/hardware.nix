{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    # included common-gpu-intel
    common-cpu-intel
    # included prime
    # https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia/prime.nix
    common-gpu-nvidia
    common-pc-ssd
  ];

  # boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "uas"
    "sd_mod"
  ];
  # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
  boot.initrd.kernelModules = [
    "uas"
    "usbcore"
    "usb_storage"
    "vfat"
    "nls_cp437"
    "nls_iso8859_1"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  # use cachyos kernel + sched-ext/scx (scx_rusty)
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = true;
  # TODO: wait upstream fix
  # https://github.com/chaotic-cx/nyx/blob/a7a28bea9c55041a3bd5e253f8ac7f1e05b90c56/modules/nixos/scx.nix#L27
  # chaotic.scx.scheduler = "scx_rusty";

  # https://nixos.wiki/wiki/Intel_Graphics
  # Intel Corporation Alder Lake-S GT1 [UHD Graphics 730] [8086:4692]
  # Intel Corporation DG2 [Arc A770] [8086:56a0]
  boot.kernelParams = [
    # Workaround iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    # https://github.com/NixOS/nixos-hardware/blob/53db5e1070d07e750030bf65f1b9963df8f0c678/framework/13-inch/12th-gen-intel/default.nix#L15-L17
    "i915.enable_psr=1"
  ];

  # https://wiki.nixos.org/wiki/Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Hybrid graphics
  # https://nixos.wiki/wiki/Nvidia#Laptop_Configuration:_Hybrid_Graphics_.28Nvidia_Optimus_PRIME.29
  # nix run nixpkgs#lshw -- -c display
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # services.xserver.videoDrivers = ["intel"];
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];

  # CUDA Support
  nixpkgs.config.cudaSupport = true;

  # Intel GPU Tools
  environment.systemPackages = with pkgs; [ intel-gpu-tools ];

  # fix i915 GuC / HuC
  hardware.firmware = with pkgs; [ linux-firmware ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [ intel-compute-runtime ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
