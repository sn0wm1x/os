{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Yubikey#GPG_and_SSH
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  environment.systemPackages = with pkgs; [ yubikey-personalization ];
  services.udev.packages = with pkgs; [ yubikey-personalization ];

  # https://nixos.wiki/wiki/Yubikey#Smartcard_mode
  services.pcscd.enable = true;

  # https://nixos.wiki/wiki/Yubikey#pam_u2f
  security.pam.u2f.enable = true;
  security.pam.u2f.control = "required";
  security.pam.services.login.u2fAuth = true;
  security.pam.services.sudo.u2fAuth = true;

  # https://nixos.wiki/wiki/Yubikey#Locking_the_screen_when_a_Yubikey_is_unplugged
  services.udev.extraRules = ''
    ACTION=="remove",\
    ENV{ID_BUS}=="usb",\
    ENV{ID_MODEL_ID}=="0407",\
    ENV{ID_VENDOR_ID}=="1050",\
    ENV{ID_VENDOR}=="Yubico",\
    RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
