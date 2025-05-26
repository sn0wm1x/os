{ config, pkgs, ... }:
{
  programs.gpg.enable = true;
  programs.gpg.publicKeys = [
    {
      source = pkgs.fetchurl {
        # https://keys.openpgp.org/search?q=4444777733334444
        url = "https://keys.openpgp.org/vks/v1/by-fingerprint/ABCBA12F1A8E3CCCF10B51094444777733334444";
        hash = "sha256-iywF/mKcNd2sPNDCVFvvhLD6IBmCTSh8gVh9YJHsgoE=";
      };
      trust = 5;
    }
  ];

  # https://support.yubico.com/hc/en-us/articles/4819584884124-Resolving-GPG-s-CCID-conflicts
  programs.gpg.scdaemonSettings.disable-ccid = true;
  # programs.gpg.scdaemonSettings.reader-port = "Yubico Yubi";

  home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".gnupg/private-keys-v1.d"
    # {
    #   directory = ".gnupg/private-keys-v1.d";
    #   mode = "0700";
    # }
  ];
}
