{ ... }: {
  imports = [
    ./circle.nix
    ./extensions.nix
    ./gradience.nix
    ./gtk.nix
    ./ptyxis.nix
    ./wallpaper.nix
  ];

  # Enable VRR
  dconf.settings."org/gnome/mutter" = {
    experimental-features = [ "variable-refresh-rate" ];
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
