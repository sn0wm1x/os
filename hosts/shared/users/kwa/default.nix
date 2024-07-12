{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.kwa = {
    # FIXME: update password
    initialPassword = "correcthorsebatterystaple";
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
    packages = [ pkgs.home-manager ];
  };

  # home-manager.users.kwa = import ../../../../home/kwa/${config.networking.hostName}.nix;
}
