{ inputs, ... }: {
  imports = [ inputs.sn0wm1x.nixosModules.hatsu ];

  services.hatsu = {
    enable = true;
    port = 4040;
    domain = "hatsu.local";
    primaryAccount = "kwaa.dev";
  };
}
