{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  virtualisation.podman.autoPrune.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  # virtualisation.oci-containers.backend = "podman";

  # TODO: https://carjorvaz.com/posts/rootless-podman-and-docker-compose-on-nixos/
  # TODO: https://nixos.wiki/wiki/Podman#Use_Podman_within_nix-shell
  # TODO: systemd-nspawn

  environment.systemPackages = with pkgs; [
    distrobox
    # lazydocker
    podman-compose
    podman-desktop
    podman-tui
    qemu
  ];
  environment.persistence."/persist".directories = [
    "/var/lib/containers"
  ];
}