{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    # TODO: use https://github.com/paper-plane-developers/paper-plane
  ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/TelegramDesktop"
  ];
}
