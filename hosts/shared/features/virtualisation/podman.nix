{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  virtualisation.podman.autoPrune.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "podman";

  # TODO: https://carjorvaz.com/posts/rootless-podman-and-docker-compose-on-nixos/
  # TODO: https://nixos.wiki/wiki/Podman#Use_Podman_within_nix-shell

  environment.systemPackages = with pkgs; [
    buildah # A tool that facilitates building OCI images

    # https://gist.github.com/adisbladis/187204cb772800489ee3dac4acdd9947#file-podman-shell-nix-L45-L48
    conmon # Container runtime monitor
    skopeo # Interact with container registry
    slirp4netns # User-mode networking for unprivileged namespaces
    fuse-overlayfs # CoW for images, much faster than default vfs
  ];

  environment.persistence."/persist".directories = [
    "/var/lib/containers"
  ];
}
