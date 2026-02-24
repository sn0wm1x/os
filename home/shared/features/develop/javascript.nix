{ pkgs, ... }:
let
  corepackWithoutCheck = pkgs.corepack.overrideAttrs (oldAttrs: {
    doInstallCheck = false;
  });
in
{
  home.packages = with pkgs; [
    bun
    deno
    nodejs_latest
    # corepack
    corepackWithoutCheck
  ];
  home.persistence."/persist".directories = [
    # ".bun"
    # ".cache/deno"
    ".cache/node/corepack"
    # ".npm"
    # ".yarn"
    # ".local/share/pnpm"
  ];
  # home.sessionVariables = {
  #   PNPM_HOME = "$HOME/.local/share/pnpm";
  # };
}
