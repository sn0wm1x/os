{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    boxbuddy # https://github.com/Dvlv/BoxBuddyRS
    distrobox
    # lazydocker
    podman-compose
    podman-tui
    pods # https://github.com/marhkb/pods
  ];
  home.shellAliases = {
    docker-compose = "podman-compose";
  };
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/containers/storage"
  ];
}
