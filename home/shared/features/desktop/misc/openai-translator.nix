{ outputs, pkgs, ... }: {
  home.packages = with outputs.packages.${pkgs.system}; [ openai-translator-bin ];
}
