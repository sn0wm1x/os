{
  config,
  lib,
  ...
}:
let
  cfg = config.sn0wm1x.impermanence;
in
with lib;
{
  options.sn0wm1x.impermanence = {
    enable = mkEnableOption "SN0WM1X impermanence configurations";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist" = {
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
    };

    # https://github.com/nix-community/impermanence/issues/256
    home.activation.fixPathForImpermanence = lib.hm.dag.entryBefore [ "cleanEmptyLinkTargets" ] ''
      PATH=$PATH:/run/wrappers/bin
    '';
  };
}
