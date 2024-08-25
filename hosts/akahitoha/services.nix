{
  services.ollama = {
    enable = false;
    acceleration = "rocm";
    # https://github.com/ollama/ollama/pull/5426
    # https://github.com/ollama/ollama/pull/6282
    rocmOverrideGfx = "11.0.1";
    home = "/home/kwa/Documents/ollama";
  };
}
