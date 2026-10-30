{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  python3,
  zstd,
  linuxPackages,
  kernel ? linuxPackages.kernel,
  kernelModuleMakeFlags ? linuxPackages.kernelModuleMakeFlags,
}:
let
  version = "2.0.0-unstable-2026-10-28";
  nv = "610.43.03";

  kernelSource = fetchurl {
    url = "https://download.nvidia.com/XFree86/NVIDIA-kernel-module-source/NVIDIA-kernel-module-source-${nv}.tar.xz";
    hash = "sha256-fhGJI8eiPtw2EU1jJzpG4+BOmvmGlaQiA+esLf6fwdw=";
  };

  installer = fetchurl {
    url = "https://download.nvidia.com/XFree86/Linux-x86_64/${nv}/NVIDIA-Linux-x86_64-${nv}-no-compat32.run";
    hash = "sha256-4IRFHbcwpt8p09dPZVdJxNI248lF99lLUgXoQxj+L5A=";
  };
in
stdenv.mkDerivation {
  pname = "gpu-unlock";
  version = "${version}-${kernel.version}";

  src = fetchFromGitHub {
    owner = "Zagitta";
    repo = "gpu-unlock";
    rev = "7eb51bccae0a0b7e599e084d971170e9a1e82d0c";
    hash = "sha256-1KD/J1S1uyI5GGoTwQ1cU/sXeEKlG54exSvi6U+j73M=";
  };

  outputs = [
    "out"
    "firmware"
  ];

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [
    python3
    zstd
  ];
  hardeningDisable = [ "pic" ];

  # Preserve the extracted firmware and its embedded metadata unchanged.
  dontStrip = true;
  dontPatchELF = true;

  preBuild = ''
    mkdir -p "$TMPDIR/inputs"
    ln -s ${kernelSource} "$TMPDIR/inputs/NVIDIA-kernel-module-source-${nv}.tar.xz"
    ln -s ${installer} "$TMPDIR/inputs/NVIDIA-Linux-x86_64-${nv}-no-compat32.run"
    make firmware INPUTS="$TMPDIR/inputs" ASSETS="$TMPDIR/assets"
  '';

  makeFlags = kernelModuleMakeFlags ++ [
    "-C"
    "kernel/gpu_unlock"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    runHook preInstall
    install -Dm644 kernel/gpu_unlock/gpu_unlock.ko \
      $out/lib/modules/${kernel.modDirVersion}/extra/gpu_unlock.ko
    install -Dm644 -t $out/share/licenses/gpu-unlock \
      licenses/GPL-2.0.txt licenses/NVIDIA-MIT.txt licenses/CMP40HX-MIT.txt
    make install-firmware ASSETS="$TMPDIR/assets" \
      FWDIR="$firmware/lib/firmware/gpu-unlock/${nv}" \
      LICENSEDIR="$firmware/share/licenses"
    runHook postInstall
  '';

  meta = {
    description = "Pre-driver tensor throughput unlock for supported NVIDIA GPUs";
    homepage = "https://github.com/Zagitta/gpu-unlock";
    license = with lib.licenses; [
      gpl2Only
      unfreeRedistributableFirmware
    ];
    platforms = [ "x86_64-linux" ];
  };
}
