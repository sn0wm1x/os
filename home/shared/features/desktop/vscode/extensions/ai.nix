{ osConfig, pkgs, lib, ... }:
let host = osConfig.networking.hostName;
in {
  programs.vscode = lib.optional (host == "bluestar")
    {
      extensions = with pkgs.vscode-extensions; [
        continue.continue
      ];
      userSettings = {
        "continue.telemetryEnabled" = false;
      };
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
