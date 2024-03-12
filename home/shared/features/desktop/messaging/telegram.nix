{ pkgs, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
  ];
  home.persistence."/persist/home/kwa".directories = [
    ".local/share/TelegramDesktop"
  ];
}
