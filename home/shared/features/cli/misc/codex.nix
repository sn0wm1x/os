{ pkgs, ... }: {
  # https://home-manager-options.extranix.com/?query=codex&release=master
  programs.codex = {
    enable = true;
    package = pkgs.llm-agents.codex;
    # settings = {
    #   model = "gpt-oss";
    #   model_provider = "ollama";
    #   approval_policy = "untrusted";
    #   sandbox_mode = "workspace-write";
    # };
  };

  home.packages = with pkgs.llm-agents; [
    ccusage-codex
    # rtk
  ];

  home.persistence."/persist".directories = [
    ".codex"
  ];
}
