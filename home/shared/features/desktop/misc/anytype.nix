{ config, pkgs, ... }: {
  home.packages = with pkgs; [ anytype ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".config/anytype" ];
}
