{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # https://nixos.wiki/wiki/GNOME#Excluding_some_GNOME_applications_from_the_default_install
  environment.gnome.excludePackages =
    (with pkgs; [
      # gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      # gnome-terminal
      # gedit # text editor
      epiphany # web browser
      geary # email reader
      # evince # document viewer
      # gnome-characters
      totem # video player
      # tali # poker game
      # iagno # go game
      # hitori # sudoku game
      # atomix # puzzle game
    ]);

  environment.systemPackages = with pkgs.gnome; [
    dconf-editor
    gnome-shell-extensions
    gnome-tweaks
  ];
}
