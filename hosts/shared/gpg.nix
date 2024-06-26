{ lib
, pkgs
, ...
}: {
  # https://nixos.wiki/wiki/Yubikey
  environment.systemPackages = with pkgs; [ yubikey-personalization ];
  services.udev.packages = with pkgs; [ yubikey-personalization ];
  services.pcscd.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.sessionVariables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      # temporary fix `gpg --card-status`
      "${lib.getLib pkgs.pcsclite}/lib"
    ];
  };
}
