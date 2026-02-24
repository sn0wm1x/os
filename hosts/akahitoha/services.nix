{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
      OLLAMA_CONTEXT_LENGTH = "131072"; # 128K
      # OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };
}
