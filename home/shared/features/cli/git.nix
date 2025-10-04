{ pkgs, ... }:
{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # difftastic
  programs.git.difftastic.enable = true;

  # TODO: mergiraf
  # https://github.com/NixOS/nixpkgs/pull/354870

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
