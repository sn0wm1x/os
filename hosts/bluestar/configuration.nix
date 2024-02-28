{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Enable flakes and new 'nix' command
  nix.settings.experimental-features = "nix-command flakes";
  # Deduplicate and optimize nix store
  nix.settings.auto-optimise-store = true;
  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # FIXME: Add the rest of your current configuration

  networking.hostName = "bluestar";

  boot.loader.systemd-boot.enable = true;

  users.mutableUsers = false;
  users.users = {
    root.initialPassword = "correcthorsebatterystaple";
    kwa = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApPwSaizmGRsjTbeFUuzAw/U1zHbVM4ybsN3iILi0mm openpgp:0x22222222" # 0x4444777733334444
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
    };
  };

  services.openssh.enable = true;
  # Forbid root login through SSH.
  services.openssh.settings.PermitRootLogin = "no";
  # Use keys only. Remove if you want to SSH using password (not recommended)
  services.openssh.settings.PasswordAuthentication = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
