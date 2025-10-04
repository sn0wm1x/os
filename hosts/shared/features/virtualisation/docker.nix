{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker = {
    enable = true;
    # optimize boot time (systemd-analyze critical-chain)
    # TODO: enable when host is a server
    enableOnBoot = false;
    storageDriver = "btrfs";
    # TODO: https://wiki.nixos.org/wiki/Docker#Storage_space_issues
    # TODO: https://wiki.nixos.org/wiki/Distrobox
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "docker";

  environment.persistence."/persist".directories = [ "/var/lib/docker" ];
}
