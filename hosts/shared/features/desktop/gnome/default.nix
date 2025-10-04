{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # https://wiki.nixos.org/wiki/GNOME#GNOME_desktop
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music # music player
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    totem # video player
  ];

  # https://wiki.nixos.org/wiki/GNOME#GNOME_power_user_apps
  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-shell-extensions
    gnome-tweaks
    refine
  ];

  # Maybe: https://wiki.nixos.org/wiki/GNOME#GNOME_Qt_integration
}
