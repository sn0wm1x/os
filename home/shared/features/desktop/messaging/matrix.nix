{ pkgs, ... }: {
  home.packages = with pkgs; [ fractal ];
  home.persistence."/persist/home/kwa".directories = [
    ".local/share/fractal"
  ];
}