{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ gemini-cli ];

  home.file.".gemini/settings.json".text = builtins.toJSON {
    theme = "ANSI";
    selectedAuthType = "oauth-personal";
  };

  home.persistence."/persist${config.home.homeDirectory}".files = [
    ".gemini/oauth_creds.json"
    ".gemini/user_id"
  ];
}
