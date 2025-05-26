{ pkgs, ... }:
{
  users.users.kwa = {
    # FIXME: update password
    initialPassword = "147147";
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApPwSaizmGRsjTbeFUuzAw/U1zHbVM4ybsN3iILi0mm openpgp:0x22222222" # 0x4444777733334444
    ];
    # packages = [ pkgs.home-manager ];
  };
}
