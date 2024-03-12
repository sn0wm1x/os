{ ... }: {
  imports = [
    ./cursor.nix
    ./extensions.nix
    ./gradience.nix
    ./gtk.nix
  ];

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    font-antialiasing = "rgba";
    font-name = "Noto Sans CJK SC 12";
    document-font-name = "Noto Sans CJK SC 12";
    monospace-font-name = "MonospiceNe Nerd Font 10";
  };
}