{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sn0wm1x.virtualisation;
in
{
  options.sn0wm1x.virtualisation = {
    docker.enable = lib.mkEnableOption "SN0WM1X Docker configurations";
    libvirt.enable = lib.mkEnableOption "SN0WM1X libvirt configurations";
    # TODO: Add an incus.enable option when its configuration is ready.
    # TODO: Add a waydroid.enable option when its configuration is ready.
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.docker.enable {
      # https://wiki.nixos.org/wiki/Docker
      virtualisation.docker = {
        enable = true;
        # optimize boot time (systemd-analyze critical-chain)
        # TODO: enable when host is a server
        enableOnBoot = false;
        storageDriver = "btrfs";
        # TODO: https://wiki.nixos.org/wiki/Docker#Storage_space_issues
        # TODO: https://wiki.nixos.org/wiki/Distrobox
      };

      environment.systemPackages = with pkgs; [ docker-compose ];

      # virtualisation.containers.enable = true;
      virtualisation.oci-containers.backend = "docker";

      environment.persistence."/persist".directories = [ "/var/lib/docker" ];
    })

    (lib.mkIf cfg.libvirt.enable {
      # https://wiki.nixos.org/wiki/Libvirt
      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

      # https://wiki.nixos.org/wiki/Virt-manager
      programs.virt-manager.enable = true;
    })
  ];
}
