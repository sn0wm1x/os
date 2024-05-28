{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
  ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/TelegramDesktop"
  ];
}
