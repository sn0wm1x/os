{ outputs, inputs, lib, config, pkgs, ... }: {
  imports = [
    # ./fonts.nix
  ];

  programs.home-manager.enable = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    # bbenoist.nix
    # https://github.com/nix-community/vscode-nix-ide
    jnoortheen.nix-ide
  ];
  programs.vscode.userSettings = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${lib.getExe pkgs.alejandra}";
    "nix.serverPath" = "${lib.getExe pkgs.nil}";
    "nix.serverSettings"."nil"."formatting"."command" = [ "${lib.getExe pkgs.alejandra}" ];
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = lib.mkDefault "23.11";
}
