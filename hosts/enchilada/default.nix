{ inputs, ... }: {
  imports = [
    (import "${inputs.mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
    ../shared
    # ../shared/features/desktop/common # exclude fcitx5
    ../shared/features/desktop/common/pipewire.nix
    ../shared/features/desktop/common/wayland.nix
    ../shared/features/desktop/gnome
    # ../shared/features/virtualisation
    ../shared/users/kwa
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
