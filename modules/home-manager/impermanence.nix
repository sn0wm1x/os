{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.sn0wm1x.impermanence;
in
with lib;
{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  options.sn0wm1x.impermanence = {
    enable = mkEnableOption "SN0WM1X impermanence configurations";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist${config.home.homeDirectory}" = {
      # https://github.com/nix-community/impermanence#home-manager
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".os" # github:sn0wm1x/os
      ];
      files = [
        ".ssh/known_hosts"
      ];
      allowOther = lib.mkForce true;
      # https://github.com/nix-community/impermanence/issues/206
      # https://github.com/nix-community/impermanence/issues/248
      defaultDirectoryMethod = "symlink";
    };
  };
}
