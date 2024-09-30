{ inputs, ... }: {
  imports = [ inputs.sn0wm1x.nixosModules.hatsu ];

  services.hatsu = {
    enable = true;
    settings = {
      HATSU_LISTEN_PORT = 4040;
      HATSU_DOMAIN = "hatsu.local";
      HATSU_PRIMARY_ACCOUNT = "kwaa.dev";
    };
  };
}
