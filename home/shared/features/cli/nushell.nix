{config, ...}: {
  # https://nixos.wiki/wiki/Nushell
  programs.nushell = {
    inherit (config.home) shellAliases;
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
          # set to false to prevent nushell looking into $env.PATH to find more suggestions
          enable: true
          # set to lower can improve completion performance at the cost of omitting some options
          max_results: 100
          completer: $carapace_completer # check 'carapace_completer'
          }
        }
      }
      $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
      )
    '';
  };

  programs.atuin.enable = true;
  programs.atuin.enableNushellIntegration = true;

  # TODO: https://github.com/sharkdp/bat#integration-with-other-tools
  # TODO: https://github.com/catppuccin/bat#adding-the-themes
  programs.bat.enable = true;

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  programs.fzf.enable = true;
  # https://github.com/catppuccin/fzf#usage
  programs.fzf.colors = {
    "bg+" = "#414559";
    "bg" = "#303446";
    "spinner" = "#f2d5cf";
    "hl" = "#e78284";
    "fg" = "#c6d0f5";
    "header" = "#e78284";
    "info" = "#ca9ee6";
    "pointer" = "#f2d5cf";
    "marker" = "#f2d5cf";
    "fg+" = "#c6d0f5";
    "prompt" = "#ca9ee6";
    "hl+" = "#e78284";
  };

  # TODO: https://github.com/catppuccin/starship
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = true;
    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[➜](bold red)";
    };
  };

  # TODO: https://github.com/catppuccin/yazi#usage
  programs.yazi.enable = true;
  programs.yazi.enableNushellIntegration = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableNushellIntegration = true;

  home.persistence."/persist/home/kwa".directories = [
    ".local/share/atuin"
    ".local/share/zoxide"
  ];
}
