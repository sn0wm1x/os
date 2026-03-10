{ pkgs, ... }:
{
  home.packages = with pkgs; [
    beekeeper-studio # https://github.com/beekeeper-studio/beekeeper-studio/
    sqlitebrowser # https://github.com/sqlitebrowser/sqlitebrowser
  ];

  home.persistence."/persist".directories = [
    ".config/beekeeper-studio"
  ];
}
