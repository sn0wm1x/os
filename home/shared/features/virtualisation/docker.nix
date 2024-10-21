{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    boxbuddy # https://github.com/Dvlv/BoxBuddyRS
    distrobox
    dive # look into docker image layers
    lazydocker
    pods # https://github.com/marhkb/pods
  ];

  xdg.configFile = {
    "pods/connections.json".text = builtins.toJSON {
      "21950ebf-11f6-4f6a-bfe8-10ea6b174e9c" = {
        uuid = "21950ebf-11f6-4f6a-bfe8-10ea6b174e9c";
        name = "Docker System";
        url = "unix:///var/run/docker.sock";
        rgb = null;
      };
      "25fe4ed7-7f14-4b2d-bac0-17102c9ea65d" = {
        uuid = "25fe4ed7-7f14-4b2d-bac0-17102c9ea65d";
        name = "Docker User";
        url = "unix:///run/user/1000/docker.sock";
        rgb = null;
      };
    };

    "distrobox/distrobox.ini" = {
      text = lib.generators.toINI { } {
        arch = {
          image = "ghcr.io/ublue-os/arch-distrobox";
          pull = true;
          root = false;
          replace = false;
        };
        # bazzite-arch = {
        #   image = "ghcr.io/ublue-os/bazzite-arch-gnome";
        # };
      };
      # onChange = "distrobox assemble create";
    };
  };

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/docker" ];
}
