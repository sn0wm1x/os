{ pkgs, osConfig, ... }:
let
  cfg = osConfig.nixpkgs.config;
  nvtop =
    with pkgs.nvtopPackages;
    if cfg.cudaSupport then
      full
    else if cfg.rocmSupport then
      amd
    else
      intel;
in
{
  home.packages = [
    nvtop
  ];
}
