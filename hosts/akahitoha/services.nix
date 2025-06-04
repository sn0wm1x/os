{
  services.ollama = {
    enable = true;
    # acceleration = "rocm";
    # https://github.com/ollama/ollama/pull/5426
    # https://github.com/ollama/ollama/pull/6282
    # rocmOverrideGfx = "11.0.2";
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables.OLLAMA_ORIGINS = "*";
  };
}
