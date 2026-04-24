{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  cfg = config.sn0wm1x.impermanence;
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.sn0wm1x.impermanence = {
    enable = lib.mkEnableOption "SN0WM1X impermanence configurations";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      sharedModules = [ outputs.homeManagerModules.impermanence ];
      users.kwa.sn0wm1x.impermanence.enable = true;
    };

    # https://github.com/nix-community/impermanence#btrfs-subvolumes
    # https://github.com/nix-community/impermanence/issues/320#issuecomment-4260870035
    boot.initrd.systemd = {
      services.impermanence-btrfs-rolling-root =
        let
          # mtime = "30"; # monthly
          mtime = "7"; # weekly
          # mtime = "1"; # daily
        in
        {
          description = "Archiving existing BTRFS root subvolume and creating a fresh one";
          # Specify dependencies explicitly
          unitConfig.DefaultDependencies = false;
          # The script needs to run to completion before this service is done
          serviceConfig = {
            Type = "oneshot";
            # NOTE: to be able to see errors in your script do this
            # StandardOutput = "journal+console";
            # StandardError = "journal+console";
          };
          # This service is required for boot to succeed
          requiredBy = [ "initrd.target" ];
          # Should complete before any file systems are mounted
          before = [ "sysroot.mount" ];

          # Wait until the root device is available
          # If you're altering a different device, specify its device unit explicitly.
          # see: systemd-escape(1)
          requires = [ "initrd-root-device.target" ];
          after = [
            "initrd-root-device.target"
            # Allow hibernation to resume before trying to alter any data
            "local-fs-pre.target"
          ];

          # The body of the script. Make your changes to data here
          script = ''
            mkdir /btrfs_tmp
            mount /dev/mapper/cryptroot /btrfs_tmp

            if [[ -e /btrfs_tmp/root ]]; then
              mkdir -p /btrfs_tmp/old_roots
              timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
              mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            delete_subvolume_recursively() {
              IFS=$'\n'
              for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                echo "removing $i ..."
                delete_subvolume_recursively "/btrfs_tmp/$i"
              done
              btrfs subvolume delete "$1"
            }

            for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${mtime}); do
              delete_subvolume_recursively "$i"
            done

            btrfs subvolume create /btrfs_tmp/root
            umount /btrfs_tmp
          '';
        };

      extraBin = {
        "mkdir" = "${pkgs.coreutils}/bin/mkdir";
        "date" = "${pkgs.coreutils}/bin/date";
        "stat" = "${pkgs.coreutils}/bin/stat";
        "mv" = "${pkgs.coreutils}/bin/mv";
        "find" = "${pkgs.findutils}/bin/find";
        "btrfs" = "${pkgs.btrfs-progs}/bin/btrfs";
        # mount & umount already exist
      };
    };

    programs.fuse.userAllowOther = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      # https://nixos.wiki/wiki/Impermanence#Persisting
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/tmp"
      ]
      ++ lib.optional config.hardware.bluetooth.enable "/var/lib/bluetooth"
      ++ lib.optional config.networking.wireless.iwd.enable "/var/lib/iwd"
      ++ lib.optional config.networking.networkmanager.enable "/etc/NetworkManager/system-connections";
      files = [ "/etc/machine-id" ];
    };
  };
}
