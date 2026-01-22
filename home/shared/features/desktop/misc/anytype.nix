{ pkgs, ... }: {
  home.packages = with pkgs; [ anytype ];
  home.persistence."/persist".directories = [ ".config/anytype" ];
}
