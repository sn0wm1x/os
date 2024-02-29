{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-shell-extensions
    gnome.gnome-tweaks
    gnomeExtensions.gsconnect
    gnomeExtensions.blur-my-shell
    gnomeExtensions.paperwm
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-dock
  ];
}
