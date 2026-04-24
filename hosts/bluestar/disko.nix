{ ... }:
let
  device = "/dev/nvme0n1";
  primary_key = "/dev/disk/by-id/usb-Lenovo_SX1_Pro_32G_FC372704102414525-0:0-part1";
  backup_key = "/dev/disk/by-id/usb-Realtek_RTL9210B-CG_012345678939-0:0-part1";
in
{
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
                keyFile = "/key/os.key";
                keyFileSize = 8192;
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  # https://github.com/nix-community/impermanence#btrfs-subvolumes
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                  "/opt" = {
                    mountpoint = "/opt";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  # https://wiki.nixos.org/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_USB_stick
  boot.initrd.systemd.services = {
    initrd-mount-cryptroot-key = {
      description = "Mount external key for cryptroot";
      wantedBy = [ "systemd-cryptsetup@cryptroot.service" ];
      before = [
        "systemd-cryptsetup@cryptroot.service"
        "shutdown.target"
      ];
      after = [ "systemd-modules-load.service" ];
      conflicts = [ "shutdown.target" ];
      unitConfig.DefaultDependencies = false;
      script = ''
        mkdir -m 0755 -p /key
        sleep 5
        mount -n -t exfat -o ro ${primary_key} /key || mount -n -t exfat -o ro ${backup_key} /key
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };

    initrd-umount-cryptroot-key = {
      description = "Unmount external key for cryptroot";
      wantedBy = [ "initrd-fs.target" ];
      before = [
        "initrd-fs.target"
        "shutdown.target"
      ];
      after = [
        "systemd-cryptsetup@cryptroot.service"
        "cryptsetup.target"
      ];
      conflicts = [ "shutdown.target" ];
      unitConfig.DefaultDependencies = false;
      script = ''
        umount /key || true
        rm -rf /key
      '';
      serviceConfig.Type = "oneshot";
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
