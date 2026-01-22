{ pkgs, ... }:
{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.settings = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # difftastic
  programs.difftastic.enable = true;

  # mergiraf
  programs.mergiraf.enable = true;

  # gitui
  programs.gitui.enable = true;
  catppuccin.gitui.enable = true;

  # gh
  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    # gh-dash
    gh-markdown-preview
    gh-notify
    gh-poi
  ];

  # gh-dash
  programs.gh-dash.enable = true;
  catppuccin.gh-dash.enable = true;
}
