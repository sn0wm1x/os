{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    deno
    nodejs_latest
    corepack.override {
      nodejs = nodejs_latest;
    }
  ];
  home.persistence."/persist${config.home.homeDirectory}".directories = [
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
