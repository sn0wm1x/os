{ inputs, ... }: {
  imports = [
    (import "${inputs.mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
    # inputs.gnome-mobile.nixosModules.gnome-mobile
    ../shared/mobile
    ../shared/features/desktop/common/pipewire.nix
    ../shared/features/desktop/common/wayland.nix
    ../shared/users/kwa/mobile.nix
    ./gnome-mobile
    ./ibus.nix
  ];

  networking.hostName = "enchilada";
  # networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  # networking.networkmanager.wifi.backend = "iwd";

  users.mutableUsers = false;
  # FIXME: update password
  users.users.root.initialPassword = "correcthorsebatterystaple";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
