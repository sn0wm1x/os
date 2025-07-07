{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    dive # look into docker image layers
    lazydocker
  ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".local/share/docker" ];
}
