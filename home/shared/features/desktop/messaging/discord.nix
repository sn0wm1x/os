{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Discord#Vesktop
  home.packages = with pkgs; [ vesktop ];
  home.persistence."/persist/home/kwa".directories = [ ".config/vesktop" ];
}