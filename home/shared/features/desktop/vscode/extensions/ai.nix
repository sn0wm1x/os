{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs; [
      vscode-extensions.continue.continue
    ];
    userSettings = {
      "continue.telemetryEnabled" = false;
    };
  };

  home.file.".continue/config.json".text = builtins.toJSON {
    models = [
      # {
      #   title = "Qwen 2.5 3B";
      #   provider = "ollama";
      #   model = "qwen2.5:3b";
      # }
      {
        title = "Qwen 2.5 Coder 3B";
        provider = "ollama";
        model = "qwen2.5-coder:3b";
      }
    ];
    tabAutocompleteModel = {
      title = "Qwen 2.5 Coder 3B";
      provider = "ollama";
      model = "qwen2.5-coder:3b";
    };
    embeddingsProvider = {
      provider = "ollama";
      model = "nomic-embed-text";
    };
  };
}
