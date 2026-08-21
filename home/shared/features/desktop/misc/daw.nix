{ pkgs, outputs, ... }: {
  home.packages =  with outputs.packages.${pkgs.stdenv.hostPlatform.system}; [ zrythm ];
}
