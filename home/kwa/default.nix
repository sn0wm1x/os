# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{
  outputs,
  osConfig,
  ...
}:
let
  host = osConfig.networking.hostName;
in
{
  imports = [
    ../shared/features/audio
    ../shared/features/cli
    ../shared/features/desktop
    ../shared/features/develop
    ../shared/features/virtualisation
    ./programs
    # import host-specific configuration
    (./. + "/${host}")
    # sn0wm1x nushell
    outputs.homeManagerModules.nushell
  ];

  sn0wm1x.nushell.enable = true;
}
