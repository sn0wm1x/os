{ pkgs, lib, ... }:
let
  corepackWithoutCheck = pkgs.corepack.overrideAttrs (oldAttrs: {
    doInstallCheck = false;
  });

  denoWithStdenv = pkgs.writeShellScriptBin "deno" ''
    export LD_LIBRARY_PATH=${
      lib.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
      ]
    }:''${LD_LIBRARY_PATH:-}
    exec ${pkgs.deno}/bin/deno "$@"
  '';
in
{
  home.packages = with pkgs; [
    bun
    denoWithStdenv
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
