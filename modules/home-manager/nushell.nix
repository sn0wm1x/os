{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:
let
  cfg = config.sn0wm1x.nushell;
  # inshellisense = pkgs.inshellisense;
  # inshellisenseWrapper = pkgs.runCommand "inshellisense-wrapper" { } ''
  #   mkdir -p "$out/bin"

  #   for bin in is inshellisense; do
  #     cat > "$out/bin/$bin" <<EOF
  #   #!${pkgs.runtimeShell}
  #   case "\$1" in
  #     init|reinit) cd "${inshellisense}/lib/node_modules/@microsoft/inshellisense" ;;
  #   esac
  #   exec "${inshellisense}/bin/$bin" "\$@"
  #   EOF
  #     chmod +x "$out/bin/$bin"
  #   done
  # '';
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
      shellAliases =
        if osConfig != null then
          config.home.shellAliases // osConfig.environment.shellAliases
        else
          config.home.shellAliases;
      # TODO: fix home.sessionVariables in nushell
      # https://github.com/NixOS/nixpkgs/pull/343036
      # https://github.com/nix-community/home-manager/issues/4313#issuecomment-1759789504
      environmentVariables = config.home.sessionVariables;
      extraConfig = ''
        # Completions
        # mainly pieced together from https://www.nushell.sh/cookbook/external_completers.html

        # carapace completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
        # + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
        # enable the package and integration bellow
        let carapace_completer = {|spans: list&lt;string&gt;|
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
        # some completions are only available through a bridge
        # eg. tailscale
        # https://carapace-sh.github.io/carapace-bin/setup.html#nushell
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

        # fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
        let fish_completer = {|spans|
          ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
        }

        # zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
        let zoxide_completer = {|spans|
            $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
        }

        # multiple completions
        # the default will be carapace, but you can also switch to fish
        # https://www.nushell.sh/cookbook/external_completers.html#alias-completions
        let multiple_completers = {|spans|
          ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
          let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

          let spans = if $expanded_alias != null {
            $spans
            | skip 1
            | prepend ($expanded_alias | split row ' ' | take 1)
          } else {
            $spans
          }
          ## alias fixer end

          match $spans.0 {
            __zoxide_z | __zoxide_zi =&gt; $zoxide_completer
            _ =&gt; $carapace_completer
          } | do $in $spans
        }

        $env.config = {
          show_banner: false,
          completions: {
            case_sensitive: false # case-sensitive completions
            quick: true           # set to false to prevent auto-selecting completions
            partial: true         # set to false to prevent partial filling of the prompt
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
              # set to false to prevent nushell looking into $env.PATH to find more suggestions
              enable: true
              # set to lower can improve completion performance at the cost of omitting some options
              max_results: 100
              completer: $multiple_completers
            }
          }
        }
        $env.PATH = ($env.PATH |
          split row (char esep) |
          prepend ${config.home.homeDirectory}/.apps |
          append /usr/bin/env
        )
      '';
        # is init nu
        # ---------------- inshellisense shell plugin ----------------
        # if "ISTERM" not-in $env and $nu.is-interactive {
        #   if $nu.is-login { is -s nu --login ; exit } else { is -s nu ; exit }
        # }
        # '';
    };

    programs.pay-respects = {
      enable = true;
      # aiIntegration = {
      #   url = "http://127.0.0.1:11434/v1/chat/completions";
      #   model = "llama3";
      #   locale = "nl-be";
      # };
    };

    programs.carapace.enable = true;
    programs.carapace.enableNushellIntegration = true;

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

    # home.packages = [ inshellisenseWrapper ];

    home.persistence = lib.mkIf config.sn0wm1x.impermanence.enable {
      "/persist" = {
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
