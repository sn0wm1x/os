{ ... }: {
  imports = [
    ./circle.nix
    ./extensions.nix
    ./gradience.nix
    ./gtk.nix
    ./ptyxis.nix
    ./wallpaper.nix
  ];

  dconf.settings."org/gnome/mutter" = {
    # Enable Dynamic Workspaces
    dynamic-workspaces = true;
    # Enable VRR & Fractional scaling
    experimental-features = [ "variable-refresh-rate" "scale-monitor-framebuffer" ];
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    font-antialiasing = "rgba";
    font-hinting = "slight";
    font-name = "Noto Sans CJK SC 12";
    document-font-name = "Noto Sans CJK SC 12";
    monospace-font-name = "MonaspiceNe Nerd Font 10";
  };
}
