{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # difftastic
  # TODO: difftastic + magit (emacs)
  programs.git.difftastic.enable = true;

  # gh
  programs.gh.enable = true;

  # lazygit
  programs.lazygit.enable = true;
}
