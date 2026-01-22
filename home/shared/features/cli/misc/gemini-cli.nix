{ pkgs, ... }:
{
  home.packages = with pkgs; [ gemini-cli ];

  home.file.".gemini/settings.json".text = builtins.toJSON {
    theme = "ANSI";
    selectedAuthType = "oauth-personal";
    # https://agents.md
    contextFileName = "AGENTS.md";
    general = {
      previewFeatures = true;
    };
  };

  home.persistence."/persist".files = [
    ".gemini/oauth_creds.json"
    ".gemini/user_id"
  ];
}
