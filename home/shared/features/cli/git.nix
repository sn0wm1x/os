{ pkgs, ... }:
{
  # git
  programs.git = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "git-utc";
      paths = with pkgs; [ git ];
      nativeBuildInputs = with pkgs; [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/git \
          --set TZ "Etc/UTC"
      '';
    };
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      # safe.directory = [];
    };
  };

  # difftastic
  programs.difftastic.enable = true;

  # mergiraf
  programs.mergiraf.enable = true;
  programs.mergiraf.enableGitIntegration = true;

  # gh
  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    # gh-dash
    gh-markdown-preview
    gh-notify
    gh-poi
  ];

  home.persistence."/persist".directories = [
    ".config/gh"
  ];

  # gh-dash
  programs.gh-dash.enable = true;
  catppuccin.gh-dash.enable = true;
}
