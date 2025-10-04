{
  dconf.settings = {
    "org/gnome/mutter" = {
      # Enable Dynamic Workspaces
      dynamic-workspaces = true;
      # Enable VRR & Fractional scaling
      # https://wiki.nixos.org/wiki/GNOME#Experimental_settings
      experimental-features = [
        "variable-refresh-rate"
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Noto Sans CJK SC 12";
      document-font-name = "Noto Sans CJK SC 12";
      monospace-font-name = "MonaspiceNe Nerd Font 10";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive";
    };
  };
}
