{ config
, inputs
, lib
, pkgs
, ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    # https://github.com/NixOS/nixos-hardware/issues/940
    # common-gpu-intel
    common-pc-ssd
  ];

  # boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
  boot.initrd.kernelModules = [ "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # https://nixos.wiki/wiki/Intel_Graphics
  # Intel Corporation Alder Lake-S GT1 [UHD Graphics 730] [8086:4692]
  # Intel Corporation DG2 [Arc A770] [8086:56a0]
  boot.kernelParams = [
    # force use UHD730
    # "i915.force_probe=4692"
    # Workaround iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    # https://github.com/NixOS/nixos-hardware/blob/53db5e1070d07e750030bf65f1b9963df8f0c678/framework/13-inch/12th-gen-intel/default.nix#L15-L17
    "i915.enable_psr=1"
  ];

  # Hybrid graphics
  # https://nixos.wiki/wiki/Nvidia#Laptop_Configuration:_Hybrid_Graphics_.28Nvidia_Optimus_PRIME.29
  # nix run nixpkgs#lshw -- -c display
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:3:0:0";
  };

  # services.xserver.videoDrivers = ["intel"];
  services.xserver.videoDrivers = [ "modesetting" ];

  # Intel GPU Tools
  environment.systemPackages = with pkgs; [ intel-gpu-tools ];

  # fix i915 GuC / HuC
  hardware.firmware = with pkgs; [ linux-firmware ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ intel-compute-runtime ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
