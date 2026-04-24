{ inputs, pkgs, ... }:
{
  home.packages = with inputs.sn0wm1x.packages.${pkgs.stdenv.hostPlatform.system}; [ godot-fbx2gltf-bin ];
}
