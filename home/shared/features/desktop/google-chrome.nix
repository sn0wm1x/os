{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
  ];
  home.persistence."/persist/home/kwa".directories = [
    ".config/google-chrome"
  ];
}
