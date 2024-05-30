{ config, pkgs, ... }: {
  home.packages = with pkgs; [ github-desktop ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".config/GitHub Desktop"
  ];
}
