{ config, ... }: {
  programs.zoxide.enable = true;
  programs.zoxide.enableNushellIntegration = true;

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".local/share/zoxide"
  ];
}
