{ config, ... }:
let
  yubikey5c = "REVd26Y1VBZ9e9JQBcJA7PD5grkEu72K3vEn7lMRK8f9rp69KdRznkQsn7dODj4p1GV/KI+w15ROqhPNkN9XiQ==,AVu/SnPs8RU9iuAZKFWv+OoUozsVP6G24Mn3NTf9A25Iak/ZT82uM5duhYtFE+6tXy5tTF4zTR8xEPWNsgFIeQ==,es256,+presence";
  yubikey5 = "ypCTV/DNJsJo/Q15WOE9ZPZP2byO7uvoIgS6CGQPj50k7csTFD4FX5B6NarknxWHO0F3okmZl5DFgfHuN1wmHA==,gix35bXF6CMLekav4IN+d59Yv8V4eBr9/4o7DcEgz4TPtXfs36mbWzfUjZKMNpEpV9Tctek1o5BNQcYP3iYhaw==,es256,+presence";
in
{
  # https://nixos.wiki/wiki/Yubikey#pam_u2f
  xdg.configFile."Yubico/u2f_keys".text = ''
    ${config.home.username}:${yubikey5c}:${yubikey5}
  '';
}
