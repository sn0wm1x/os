{ osConfig, pkgs, lib, ... }:
let host = osConfig.networking.hostName;
in {
  programs.vscode = {
    extensions =
      if host == "bluestar" then [
        pkgs.vscode-extensions.continue.continue
      ] else [ ];
    userSettings =
      if host == "bluestar" then {
        "continue.telemetryEnabled" = false;
      } else { };
  };

  home.file.".continue/config.json".text = lib.optional (host == "bluestar")
    builtins.toJSON
    {
      models = [
        {
          title = "Mistral-NeMo";
          provider = "ollama";
          model = "mistral-nemo";
        }
      ];
      tabAutocompleteModel = {
        title = "Mistral-NeMo";
        provider = "ollama";
        model = "mistral-nemo";
      };
      embeddingsProvider = {
        provider = "ollama";
        model = "nomic-embed-text";
      };
    };
}
