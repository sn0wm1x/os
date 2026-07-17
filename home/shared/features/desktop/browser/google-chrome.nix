{
  # inputs,
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  isBluestar = osConfig.networking.hostName == "bluestar";

  commandLineArgs = [
    # force ozone wayland & fcitx5 wayland fix
    # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
    "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3"

    # WebGPU
    "--enable-features=Vulkan"
  ];

  # google-chrome
  googleChromeStableBase = pkgs.google-chrome.override {
    inherit commandLineArgs;
  };

  googleChromeStable =
    if isBluestar then
      googleChromeStableBase.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          wrapProgram "$out/bin/google-chrome-stable" \
            --unset __NV_PRIME_RENDER_OFFLOAD \
            --unset __NV_PRIME_RENDER_OFFLOAD_PROVIDER \
            --unset __GLX_VENDOR_LIBRARY_NAME \
            --set DRI_PRIME pci-0000_00_02_0 \
            --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json \
            --set MESA_VK_DEVICE_SELECT '8086:a780!' \
            --set VK_DRIVER_FILES /run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json \
            --set __VK_LAYER_NV_optimus non_NVIDIA_only
        '';
      })
    else
      googleChromeStableBase;

  # google-chrome-dev / google-chrome-unstable
  googleChromeDev =
    (inputs.browser-previews.packages.${pkgs.stdenv.hostPlatform.system}.google-chrome-dev.override {
      inherit commandLineArgs;
    }).overrideAttrs
      (old: {
        postFixup = (old.postFixup or "") + ''
          wrapProgram "$out/bin/google-chrome-unstable" \
            --set DRI_PRIME pci-0000_01_00_0 \
            --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json \
            --set VK_DRIVER_FILES /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set __VK_LAYER_NV_optimus NVIDIA_only
        '';
      });
in
{
  home.packages =
    # google-chrome
    [ googleChromeStable ]
    # google-chrome-dev installs the google-chrome-unstable executable/profile.
    ++ lib.optionals isBluestar [ googleChromeDev ];

  # https://wiki.archlinux.org/title/Profile-sync-daemon
  services.psd.enable = true;
  services.psd.browsers = [ "google-chrome" ];

  # home.file.".config/google-chrome".force = true;
  home.persistence."/persist".directories = [ ".config/google-chrome" ];

  # ~/.config/google-chrome-unstable symlink
  # Stable and Dev intentionally share one profile. They must not run concurrently.
  home.file.".config/google-chrome-unstable" = lib.mkIf isBluestar {
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/google-chrome";
  };
}
