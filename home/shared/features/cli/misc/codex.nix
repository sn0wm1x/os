{
  # https://home-manager-options.extranix.com/?query=codex&release=master
  programs.codex = {
    enable = true;
    settings = {
      model = "gpt-oss";
      model_provider = "ollama";
      approval_policy = "untrusted";
      sandbox_mode = "workspace-write";
    };
  };
}
