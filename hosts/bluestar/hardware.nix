{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
let
  gpuUnlock = outputs.packages.${pkgs.stdenv.hostPlatform.system}.gpu-unlock.override {
    inherit (config.boot.kernelPackages) kernel kernelModuleMakeFlags stdenv;
  };
in
{
  imports = with inputs.nixos-hardware.nixosModules; [
    # included common-gpu-intel
    common-cpu-intel
    # included prime
    # https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia/prime.nix
    common-gpu-nvidia
    common-pc-ssd
  ];

  boot.initrd.availableKernelModules = [
    # Loaded by the early service below, before NVIDIA probing.
    "gpu_unlock"
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
    "exfat"
    "nls_cp437"
    "nls_iso8859_1"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  # TODO: FIXME: use cachyos kernel
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # https://nixos.wiki/wiki/Intel_Graphics
  # Intel Corporation Alder Lake-S GT1 [UHD Graphics 730] [8086:4692]
  # Intel Corporation DG2 [Arc A770] [8086:56a0]
  boot.kernelParams = [
    "gpu_unlock.targets=0000:01:00.0"
    # Workaround iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    # https://github.com/NixOS/nixos-hardware/blob/53db5e1070d07e750030bf65f1b9963df8f0c678/framework/13-inch/12th-gen-intel/default.nix#L15-L17
    "i915.enable_psr=1"
  ];

  boot.extraModulePackages = [ gpuUnlock ];

  boot.initrd.systemd.services.gpu-unlock = {
    description = "Unlock RTX 3090 Ti tensor throughput before NVIDIA binds";
    wantedBy = [ "sysinit.target" ];
    before = [
      "sysinit.target"
      "systemd-modules-load.service"
      "systemd-udevd.service"
      "systemd-udev-trigger.service"
    ];
    unitConfig.DefaultDependencies = false;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe gpu_unlock";
      RemainAfterExit = true;
    };
  };

  # Runtime power-off clears the unlock. Keep the normal suspend notifier
  # enabled so upstream can reapply it after suspend-to-RAM.
  hardware.nvidia.moduleParams.nvidia.NVreg_DynamicPowerManagement = "0x00";

  # https://wiki.nixos.org/wiki/Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # gpu-unlock selectors are lost when runtime PM powers the card off.
    powerManagement.finegrained = false;
    nvidiaPersistenced = true;
    open = true;
    nvidiaSettings = true;
    branch = "latest";
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
    "modesetting"
    "nvidia"
  ];

  # CUDA Support
  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.rocmSupport = false;

  # NVIDIA Container Toolkit
  hardware.nvidia-container-toolkit.enable = true;

  # Intel GPU Tools
  environment.systemPackages = with pkgs; [ intel-gpu-tools ];

  # fix i915 GuC / HuC
  hardware.firmware = [
    pkgs.linux-firmware
    gpuUnlock.firmware
  ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [ intel-compute-runtime ];

  # sudo nvidia-smi -pl 300
  systemd.services.nvidia-power-limit =
    let
      nvidia-smi = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi";
    in
    {
      wantedBy = [ "multi-user.target" ];
      wants = [ "nvidia-persistenced.service" ];
      after = [ "nvidia-persistenced.service" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${nvidia-smi} -pm 1 || true
        ${nvidia-smi} -i GPU-22273ce2-6d5b-8183-2853-d7237769581b -pl 300
      '';
    };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
