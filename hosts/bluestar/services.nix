{
  services.ollama = {
    enable = true;
    acceleration = false;
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
  };
}
