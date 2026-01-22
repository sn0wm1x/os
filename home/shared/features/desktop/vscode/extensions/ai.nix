{ pkgs, config, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      ggml-org.llama-vscode
    ];
    userSettings = {
      "llama-vscode.launch_chat" = "";
      "llama-vscode.launch_completion" = "${pkgs.llama-cpp}/bin/llama-server --fim-qwen-1.5b-default";
      "llama-vscode.launch_embeddings" = "";
      "llama-vscode.launch_training_chat" = "";
      "llama-vscode.launch_training_completion" = "";
    };
  };

  home.persistence."/persist${config.home.homeDirectory}".directories = [ ".cache/llama.cpp" ];
}
