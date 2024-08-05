{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    deno
    nodePackages_latest.nodejs
  ];
  home.shellAliases = {
    # corepack package managers
    yarn = "corepack yarn";
    yarnpkg = "corepack yarnpkg";
    pnpm = "corepack pnpm";
    # pnpx = "corepack pnpx";
    # npm = "corepack npm";
    # npx = "corepack npx";

    # npx global packages
    ni = "npx ni";
    taze = "npx taze";
  };
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
