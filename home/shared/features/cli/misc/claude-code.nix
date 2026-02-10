{
  # https://home-manager-options.extranix.com/?query=claude-code&release=master
  programs.claude-code = {
    enable = true;
    settings = {
      theme = "dark";
      model = "kimi-for-coding";
      env = {
        # https://www.kimi.com/code/docs/en/more/third-party-agents.html#claude-code
        ANTHROPIC_BASE_URL = "https://api.kimi.com/coding/";
        # ANTHROPIC_API_KEY = "";
      };
    };
    # mcpServers = {
    #   grep = {
    #     type = "http";
    #     url = "https://mcp.grep.app";
    #   };
    # };
  };
}
