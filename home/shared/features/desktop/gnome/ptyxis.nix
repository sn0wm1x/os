{pkgs, ...}: {
  home.packages = with pkgs; [ptyxis];
  dconf.settings = {
    "org/gnome/Ptyxis" = {
      default-profile-uuid = "981d2410af732dac98b7b085665331f5";
      font-name = "MonaspiceNe Nerd Font Mono 12";
      profile-uuids = ["981d2410af732dac98b7b085665331f5"];
      use-system-font = false;
    };
    "org/gnome/Ptyxis/Profiles/981d2410af732dac98b7b085665331f5" = {
      bold-is-bright = true;
      palette = "Catppuccin Frappé";
    };
  };
}
