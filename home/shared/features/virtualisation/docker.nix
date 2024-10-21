{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    boxbuddy # https://github.com/Dvlv/BoxBuddyRS
    distrobox
    dive # look into docker image layers
    lazydocker
  ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/docker" ];
}
