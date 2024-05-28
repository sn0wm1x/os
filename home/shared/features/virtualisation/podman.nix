{ config
, pkgs
, ...
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

  xdg.configFile."pods/connections.json".text = builtins.toJSON {
    "21950ebf-11f6-4f6a-bfe8-10ea6b174e9c" = {
      uuid = "21950ebf-11f6-4f6a-bfe8-10ea6b174e9c";
      name = "Podman";
      url = "unix:///run/user/1000/podman/podman.sock";
      rgb = null;
    };
  };

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/containers"
  ];
}
