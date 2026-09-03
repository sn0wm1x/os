{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../shared
    ../shared/features/desktop/gnome
    ../shared/features/virtualisation
    # inputs.chaotic.nixosModules.default
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./services.nix
    outputs.nixosModules.baseline
    outputs.nixosModules.baseline-desktop
    outputs.nixosModules.gaming
    outputs.nixosModules.impermanence
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Preserve evidence from kernel lockups and reboot automatically.
  # EFI pstore keeps the tail of the kernel log across the reboot, while the
  # hardware watchdog is a final fallback if the kernel cannot panic cleanly.
  boot.kernelParams = [
    "nmi_watchdog=1"
    # Keep enough recent graphics output in the kernel ring buffer for pstore
    # and kdump. 0x1e enables driver, KMS, PRIME, and atomic DRM diagnostics
    # without the very noisy vblank category.
    "drm.debug=0x1e"
    "log_buf_len=32M"
    "i915.error_capture=1"
    "i915.enable_hangcheck=1"
  ];
  # baseline blacklists hardware watchdog modules globally. This Intel host
  # has an iTCO watchdog, so allow it to be loaded for systemd's watchdog.
  boot.blacklistedKernelModules = lib.mkForce [ "sp5100_tco" ];
  boot.kernelModules = [ "iTCO_wdt" ];
  boot.crashDump = {
    enable = true;
    # The regular initrd includes graphics firmware and needs more than the
    # module default on this 64 GiB machine.
    reservedMemory = "512M";
  };
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = lib.mkForce 1;
    "kernel.watchdog_thresh" = 10;
    "kernel.hardlockup_panic" = 1;
    "kernel.softlockup_panic" = 1;
    "kernel.panic_on_oops" = 1;
    "kernel.panic" = 15;
    # Allow task/CPU backtraces and a deliberate crash dump over SSH or the
    # physical SysRq key if the graphics session alone is frozen.
    "kernel.sysrq" = 1;
  };

  # A crash kernel exposes the failed kernel as /proc/vmcore. Compress it to
  # persistent storage automatically, then reboot into the normal system.
  systemd.services.save-kdump = {
    description = "Save the previous kernel crash dump";
    wantedBy = [ "rescue.target" ];
    before = [ "rescue.service" ];
    after = [ "local-fs.target" ];
    unitConfig = {
      ConditionPathExists = "/proc/vmcore";
      RequiresMountsFor = "/var/lib/crash";
    };
    serviceConfig = {
      Type = "oneshot";
      TimeoutStartSec = "infinity";
    };
    script = ''
      set -eu
      dump_dir=/var/lib/crash
      stamp="$(${lib.getExe' pkgs.coreutils "date"} -u +%Y%m%dT%H%M%SZ)"
      partial="$dump_dir/vmcore-$stamp.zst.partial"

      ${lib.getExe' pkgs.coreutils "mkdir"} -p "$dump_dir"
      ${lib.getExe pkgs.zstd} -1 -T1 --stdout /proc/vmcore > "$partial"
      ${lib.getExe' pkgs.coreutils "sync"}
      ${lib.getExe' pkgs.coreutils "mv"} "$partial" "$dump_dir/vmcore-$stamp.zst"
      ${lib.getExe' pkgs.coreutils "sync"}
      ${lib.getExe' pkgs.systemd "systemctl"} --force reboot
    '';
  };

  # i915's detailed error state lives only in sysfs and is otherwise lost on
  # a hard reset. Poll for a captured hang and copy it to persistent storage.
  systemd.services.i915-error-capture = {
    description = "Persist Intel GPU error state";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    unitConfig.RequiresMountsFor = "/var/lib/crash";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "2s";
    };
    script = ''
      ${lib.getExe' pkgs.coreutils "mkdir"} -p /var/lib/crash
      while ${lib.getExe' pkgs.coreutils "sleep"} 2; do
        for card in /sys/class/drm/card[0-9]*; do
          test -r "$card/device/vendor" || continue
          test "$(< "$card/device/vendor")" = 0x8086 || continue
          test -r "$card/error" || continue

          header="$(${lib.getExe' pkgs.coreutils "head"} -c 128 "$card/error")"
          case "$header" in
            *"No error state collected"*|"") continue ;;
          esac

          stamp="$(${lib.getExe' pkgs.coreutils "date"} -u +%Y%m%dT%H%M%SZ)"
          ${lib.getExe' pkgs.coreutils "cp"} "$card/error" "/var/lib/crash/i915-error-$stamp.txt"
          ${lib.getExe' pkgs.coreutils "sync"}
          ${lib.getExe' pkgs.coreutils "sleep"} 60
        done
      done
    '';
  };

  systemd.settings.Manager = {
    RuntimeWatchdogSec = "30s";
    RebootWatchdogSec = "2min";
  };

  environment.etc."systemd/pstore.conf".text = ''
    [PStore]
    Storage=external
    Unlink=yes
  '';

  hardware.rasdaemon.enable = true;

  # This host uses an ephemeral root, so archived panic and RAS records must
  # live on the persistent filesystem to survive the next boot.
  environment.persistence."/persist".directories = [
    "/var/lib/systemd/pstore"
    "/var/lib/rasdaemon"
    "/var/lib/crash"
  ];

  # DRM debug output is substantially larger than the normal journal. Keep a
  # bounded persistent window and flush it frequently to reduce loss on reset.
  services.journald.extraConfig = lib.mkForce ''
    SystemMaxUse=1G
    RuntimeMaxUse=256M
    RateLimitIntervalSec=0
    SyncIntervalSec=5s
  '';

  networking.hostName = "bluestar";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  sn0wm1x.baseline.enable = true;
  sn0wm1x.baseline-desktop.enable = true;
  sn0wm1x.gaming.enable = true;
  sn0wm1x.impermanence.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
