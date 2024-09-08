{ config
, inputs
, lib
, pkgs
, ...
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
    "nls_cp437"
    "nls_iso8859_1"
    # microSD
    "sdhci"
    "mmc_block" # TODO: try remove this
  ];
  boot.kernelModules = [ "kvm-amd" ];
  # use linux 6.10+ testing kernel
  boot.kernelPackages = pkgs.linuxPackages_testing;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # improve battery life
  environment.systemPackages = with pkgs; [
    powertop
    ryzenadj
  ];
  services.power-profiles-daemon.enable = true;
  services.auto-epp = {
    enable = true;
    settings.Settings.epp_state_for_BAT = "power";
    settings.Settings.epp_state_for_AC = "balance_performance";
  };
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
  hardware.graphics.extraPackages = with pkgs; [
    # https://nixos.wiki/wiki/AMD_GPU#OpenCL
    rocmPackages.clr.icd
    # https://nixos.wiki/wiki/AMD_GPU#AMDVLK
    amdvlk
  ];
  hardware.graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

  # ROCm Support
  nixpkgs.config.rocmSupport = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
