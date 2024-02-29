{
  # https://nixos.wiki/wiki/Yubikey
  services.udev.packages = with pkgs; [ yubikey-personalization ];

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
