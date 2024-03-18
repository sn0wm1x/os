{pkgs, ...}: {
  home.packages = with pkgs; [gnome.gnome-boxes];

  # https://nixos.wiki/wiki/Virt-manager
  programs.virt-manager.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
