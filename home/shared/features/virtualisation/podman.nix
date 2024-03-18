{pkgs, ...}: {
  home.packages = with pkgs; [
    distrobox
    # lazydocker
    podman-compose
    podman-tui
    pods # https://github.com/marhkb/pods
  ];
  home.shellAliases = {
    docker-compose = "podman-compose";
  };
}
