{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
      OLLAMA_CONTEXT_LENGTH = "32768";
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };

  # services.open-webui.enable = true;
}
