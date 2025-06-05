{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:
let
  cfg = config.sn0wm1x.nushell;
in
with lib;
{
  options.sn0wm1x.nushell = {
    enable = mkEnableOption "SN0WM1X nushell configurations";
  };
  config = lib.mkIf cfg.enable {
    programs.atuin.enable = true;
    programs.atuin.enableNushellIntegration = true;

    # https://github.com/nix-community/nix-direnv#via-home-manager
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.direnv.enableNushellIntegration = true;

    # https://nixos.wiki/wiki/Nushell
    programs.nushell = {
      enable = true;
      shellAliases = config.home.shellAliases // osConfig.environment.shellAliases;
      # TODO: fix home.sessionVariables in nushell
      # https://github.com/NixOS/nixpkgs/pull/343036
      # https://github.com/nix-community/home-manager/issues/4313#issuecomment-1759789504
      environmentVariables = config.home.sessionVariables;
      extraConfig = ''
        # nushell config
        $env.config.show_banner = false

        # is init nu
        # ---------------- inshellisense shell plugin ----------------
        if "ISTERM" not-in $env and $nu.is-interactive {
          if $nu.is-login { is -s nu --login ; exit } else { is -s nu ; exit }
        }
      '';
    };

    programs.pay-respects = {
      enable = true;
      # aiIntegration = {
      #   url = "http://127.0.0.1:11434/v1/chat/completions";
      #   model = "llama3";
      #   locale = "nl-be";
      # };
    };

    programs.starship.enable = true;
    programs.starship.settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
    # catppuccin.starship.enable = true;

    programs.zoxide.enable = true;
    programs.zoxide.enableNushellIntegration = true;

    home.packages = with pkgs; [ inshellisense ];

    home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
      "/persist${config.home.homeDirectory}" = {
        directories = [
          ".local/share/atuin"
          ".local/share/direnv"
          ".local/share/zoxide"
        ];
        files = [ ".config/nushell/history.txt" ];
      };
    };
  };
}
