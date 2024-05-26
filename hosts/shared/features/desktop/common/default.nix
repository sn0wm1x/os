{
  imports = [
    ./fcitx5.nix
    ./pipewire.nix
  ];

  # https://nixos.wiki/wiki/Chromium#Enabling_native_Wayland_support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
