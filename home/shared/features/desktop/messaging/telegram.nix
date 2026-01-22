{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
  ];
  home.persistence."/persist".directories = [
    ".local/share/TelegramDesktop"
  ];
}
