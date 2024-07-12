{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # antares # https://github.com/antares-sql/antares
    sqlitebrowser # https://github.com/sqlitebrowser/sqlitebrowser
  ];
}
