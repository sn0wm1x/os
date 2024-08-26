{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # https://nixos.wiki/wiki/GNOME#Excluding_some_GNOME_applications_from_the_default_install
  environment.gnome.excludePackages = with pkgs; [
    # gnome-photos
    gnome-music
    gnome-tour
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    totem # video player
    # ])
    # ++ (with pkgs.gnome; [
    # gnome-terminal
    # gedit # text editor
    # evince # document viewer
    # gnome-characters
    # tali # poker game
    # iagno # go game
    # hitori # sudoku game
    # atomix # puzzle game
  ];

  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-shell-extensions
    gnome-tweaks
  ];
}
