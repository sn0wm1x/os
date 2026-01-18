{
  # https://home-manager-options.extranix.com/?query=codex&release=master
  programs.codex = {
    enable = true;
    settings = {
      model = "gpt-oss";
      model_provider = "ollama";
      model_providers = {
        ollama = {
          name = "Ollama";
          baseURL = "http://localhost:11434/v1";
          envKey = "OLLAMA_API_KEY";
        };
      };
    };
  };
}
