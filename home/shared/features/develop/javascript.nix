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

    playwright-driver.browsers
  ];

  home.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = pkgs.playwright-driver.browsers;
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = true;
    # PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "ubuntu-24.04";

    # PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  home.persistence."/persist".directories = [
    # ".bun"
    # ".cache/deno"
    ".cache/node/corepack"
    # ".npm"
    # ".yarn"
    # ".local/share/pnpm"
  ];
}
