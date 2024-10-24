{ inputs, pkgs, ... }:
{
  home.packages = with inputs.sn0wm1x.packages.${pkgs.system}; [ openai-translator-bin ];

  # https://github.com/openai-translator/openai-translator/blob/95f92ff12e0058857146d5e700658216496d657b/src/common/utils.ts#L117-L255
  # https://github.com/openai-translator/openai-translator/blob/95f92ff12e0058857146d5e700658216496d657b/src/common/types.ts#L52-L145
  xdg.configFile."xyz.yetone.apps.openai-translator/config.json".text = builtins.toJSON {
    automaticCheckForUpdates = false;
    hideTheIconInTheDock = false;
    i18n = "zh-Hans";
    languageDetectionEngine = "local";
    ollamaAPIModel = "__custom__";
    ollamaAPIURL = "http://127.0.0.1:11434";
    # ollamaCustomModelName = "gemma2";
    ollamaCustomModelName = "nemotron";
    ollamaModelLifetimeInMemory = "5m";
    provider = "Ollama";
  };
}
