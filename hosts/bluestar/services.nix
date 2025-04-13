{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables.OLLAMA_ORIGINS = "*";
  };

  # services.open-webui.enable = true;
}
