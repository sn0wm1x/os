{
  config,
  lib,
  osConfig,
  ...
}:
{
  # https://nixos.wiki/wiki/Nushell
  programs.nushell = {
    enable = true;
    shellAliases = config.home.shellAliases // osConfig.environment.shellAliases;
    extraConfig = ''
      # nushell config
      $env.config.show_banner = false

      # is init nu
      # ---------------- inshellisense shell plugin ----------------
      if "ISTERM" not-in $env and $nu.is-interactive {
        if $nu.is-login { is -s nu --login ; exit } else { is -s nu ; exit }
      }
    '';

    # TODO: fix home.sessionVariables in nushell
    # https://github.com/NixOS/nixpkgs/pull/343036
    # https://github.com/nix-community/home-manager/issues/4313#issuecomment-1759789504
    environmentVariables = builtins.mapAttrs (
      name: value: builtins.toString value
    ) config.home.sessionVariables;
  };

  home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
    "/persist${config.home.homeDirectory}".files = [ ".config/nushell/history.txt" ];
  };
}
