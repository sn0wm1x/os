{
  disko.devices.disk.main = {
    device = "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = { type = "filesystem"; format = "vfat"; mountpoint = "/boot"; };
        };
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "cryptroot";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = { mountpoint = "/"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "/persist" = { mountpoint = "/persist"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
              };
            };
          };
        };
      };
    };
  };
}
