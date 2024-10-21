{
  config,
  lib,
  pkgs,
  ...
}:
{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = lib.mkIf config.nixpkgs.config.cudaSupport true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs"; # TODO: support mobile
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "docker";

  environment.persistence."/persist".directories = [ "/var/lib/docker" ];
}
