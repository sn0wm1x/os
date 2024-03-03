{ pkgs, ... }: {
  programs.gpg.enable = true;
  programs.gpg.publicKeys = [{
    source = pkgs.fetchurl {
      # https://keys.openpgp.org/search?q=4444777733334444
      url = "https://keys.openpgp.org/vks/v1/by-fingerprint/ABCBA12F1A8E3CCCF10B51094444777733334444";
      hash = "";
    };
    trust = 5;
  }];
}