{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs; [
      vscode-extensions.continue.continue
    ];
    userSettings = {
      "continue.telemetryEnabled" = false;
    };
  };

  home.file.".continue/config.json".text = builtins.toJSON {
    models = [
      {
        title = "Qwen 2.5 Coder 1.5B";
        provider = "ollama";
        model = "qwen2.5-coder:1.5b";
      }
    ];
    tabAutocompleteModel = {
      title = "Qwen 2.5 Coder 1.5B";
      provider = "ollama";
      model = "qwen2.5-coder:1.5b";
    };
    embeddingsProvider = {
      provider = "ollama";
      model = "nomic-embed-text";
    };
  };
}
