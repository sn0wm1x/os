{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
  };

  # services.open-webui.enable = true;
}
