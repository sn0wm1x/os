{ outputs, pkgs, ... }: {
  home.packages = with outputs.packages.${pkgs.system}; [ openai-translator-bin ];

  xdg.configFile."xyz.yetone.apps.openai-translator/config.json".text = builtins.toJSON
    {
      i18n = "zh-Hans";
      ollamaAPIModel = "__custom__";
      ollamaAPIURL = "http://127.0.0.1:11434";
      ollamaCustomModelName = "gemma2";
      ollamaModelLifetimeInMemory = "5m";
      provider = "Ollama";
      themeType = "followTheSystem";
    };
}
