# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{
  outputs,
  lib,
  osConfig,
  ...
}:
let
  host = osConfig.networking.hostName;
in
{
  imports = [
    ../shared/features/cli
    ../shared/features/develop
    ../shared/features/virtualisation
    ./programs
    # import host-specific configuration
    (./. + "/${host}")
    # sn0wm1x nushell
    outputs.homeManagerModules.nushell
  ] ++ lib.optionals osConfig.sn0wm1x.baseline-desktop.enable [
    ../shared/features/audio
    ../shared/features/desktop
  ];

  sn0wm1x.nushell.enable = true;
}
