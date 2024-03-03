{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # gh
  programs.gh.enable = true;

  # lazygit
  programs.lazygit.enable = true;
}
