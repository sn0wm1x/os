{
  imports = [
    ../../shared
    ../../shared/features/audio
    ../../shared/features/cli/mobile
    ../../shared/features/mobile
    ../programs/git.nix
    ../programs/yubikey.nix
    ./gpg.nix
  ];

  home.username = "kwa";
  home.homeDirectory = "/home/kwa";

  home.file.".face".source = ../../assets/100897044_p0.png;
}
