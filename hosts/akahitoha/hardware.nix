{ config
, inputs
, lib
, pkgs
, ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    # FIXME: this device currently doesn't support CPPC
    # TODO: waiting for Lenovo to release new BIOS
    # common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop
    common-pc-ssd
    common-hidpi
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "uas" "sd_mod" ];
  # https://nixos.wiki/wiki/AMD_GPU#Make_the_kernel_use_the_correct_driver_early
  # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
  boot.initrd.kernelModules = [ "amdgpu" "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
  boot.kernelModules = [ "kvm-amd" ];
  # use linux 6.10+ testing kernel
  boot.kernelPackages = pkgs.linuxPackages_testing;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # improve battery life
  # https://nixos.wiki/wiki/Laptop#Powertop
  powerManagement.powertop.enable = true;
  environment.systemPackages = with pkgs; [ powertop ];
  services.power-profiles-daemon.enable = true;
  # https://nixos.wiki/wiki/Laptop#auto-cpufreq
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  # TODO: enable this when amd_pstate is available
  # services.auto-epp = {
  #   enable = true;
  #   settings.Settings.epp_state_for_BAT = "power";
  #   settings.Settings.epp_state_for_AC = "balance_performance";
  # };

  # install linux-firmware
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
