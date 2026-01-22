{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive # look into docker image layers
    lazydocker
  ];

  home.persistence."/persist".directories = [ ".local/share/docker" ];
}
