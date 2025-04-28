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
    # common-cpu-amd-pstate
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
  # CPPC is now enabled since NLCN30WW
  boot.kernelParams = [ "amd_pstate=guided" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # chaotic.scx.enable = true;
  # TODO: wait upstream fix
  # https://github.com/chaotic-cx/nyx/blob/a7a28bea9c55041a3bd5e253f8ac7f1e05b90c56/modules/nixos/scx.nix#L27
  # chaotic.scx.scheduler = "scx_rusty";

  services.xserver.videoDrivers = [ "amdgpu" ];

  # improve battery life
  environment.systemPackages = with pkgs; [
    powertop
    ryzenadj
  ];
  services.power-profiles-daemon.enable = true;
  # services.auto-epp = {
  #   enable = true;
  #   settings.Settings.epp_state_for_BAT = "power";
  #   settings.Settings.epp_state_for_AC = "balance_performance";
  # };
  powerManagement.enable = true;
  # https://nixos.wiki/wiki/Laptop#Powertop
  # powertop --auto-tune
  powerManagement.powertop.enable = true;
  # ryzenadj --power-saving
  systemd.services.ryzenadj = {
    description = "ryzenadj --power-saving";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.ryzenadj} --power-saving";
    };
  };

  # install linux-firmware
  hardware.firmware = with pkgs; [ linux-firmware ];

  hardware.graphics.enable = true;
  # https://nixos.wiki/wiki/AMD_GPU#Vulkan
  hardware.graphics.enable32Bit = true;
  # https://nixos.wiki/wiki/AMD_GPU#OpenCL
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  # ROCm Support
  nixpkgs.config.cudaSupport = false;
  nixpkgs.config.rocmSupport = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
