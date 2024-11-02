let
  device = "/dev/nvme0n1";
  primary_key = "/dev/disk/by-id/mmc-SA16G_0x3838f37e-part1";
  backup_key = "/dev/disk/by-id/usb-Lenovo_SX1_Pro_32G_FC372704102414525-0:0-part1";
  backup_backup_key = "/dev/disk/by-id/usb-Realtek_RTL9210B-CG_012345678939-0:0-part1";
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
                # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
                # https://github.com/reo101/rix101/blob/a6efd4146bbe0c7fb44343225b9dbf9585472597/machines/nixos/x86_64-linux/jeeves/disko.nix#L94-L107
                preOpenCommands = ''
                  mkdir -m 0755 -p /key
                  sleep 5
                  mount -n -t exfat -o ro ${primary_key} /key || mount -n -t exfat -o ro ${backup_key} /key || mount -n -t exfat -o ro ${backup_backup_key} /key
                '';
                postOpenCommands = ''
                  umount /key
                  rm -rf /key
                '';
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
  fileSystems."/persist".neededForBoot = true;
}
