{ pkgs, ... }:
{
  programs.vscode.extensions =
    with pkgs.vscode-extensions;
    [
      golang.go
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        # https://marketplace.visualstudio.com/items?itemName=bufbuild.vscode-buf
        name = "vscode-buf";
        publisher = "bufbuild";
        version = "0.7.0";
        sha256 = "";
      }
    ];
}
