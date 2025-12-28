{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
      OLLAMA_CONTEXT_LENGTH = "32768";
      # OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };

  # ramalama
  # sudo mkdir /opt/ramalama
  environment = {
    systemPackages = with pkgs; [ ramalama ];
    # https://github.com/containers/ramalama#default-container-engine
    sessionVariables.RAMALAMA_CONTAINER_ENGINE = "docker";
    etc."ramalama/ramalama.conf".source = ./ramalama.conf;
  };
}
