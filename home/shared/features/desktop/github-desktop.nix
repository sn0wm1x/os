{ pkgs, ... }: {
  home.packages = with pkgs; [
    github-desktop
  ];
  home.persistence."/persist/home/kwa".directories = [
    ".config/GitHub Desktop"
  ];
}
