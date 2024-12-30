{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    deno
    nodePackages_latest.nodejs
    corepack_latest
  ];
  # home.persistence."/persist${config.home.homeDirectory}".directories = [
  # ".bun"
  # ".cache/deno"
  # ".cache/node/corepack"
  # ".npm"
  # ".yarn"
  # ".local/share/pnpm"
  # ];
  # home.sessionVariables = {
  #   PNPM_HOME = "$HOME/.local/share/pnpm";
  # };
}
