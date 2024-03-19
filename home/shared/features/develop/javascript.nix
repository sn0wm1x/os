{pkgs, ...}: {
  home.packages = with pkgs; [
    bun
    deno
    nodePackages_latest.nodejs
  ];
  home.shellAliases = {
    yarn = "corepack yarn";
    yarnpkg = "corepack yarnpkg";
    pnpm = "corepack pnpm";
    # pnpx = "corepack pnpx";
    # npm = "corepack npm";
    # npx = "corepack npx";
  };
  # home.persistence."/persist${config.home.homeDirectory}".directories = [
  # ".bun"
  # ".cache/deno"
  # ".cache/node/corepack"
  # ".npm"
  # ".yarn"
  # ".local/share/pnpm"
  # ];
  environment.variables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };
}
