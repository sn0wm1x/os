{ inputs
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

  # use linux 6.10+ testing kernel
  boot.kernelPackages = pkgs.linuxPackages_testing;

  # TODO: other hardware config

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
