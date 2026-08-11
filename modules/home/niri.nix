{...}: {
  xdg.configFile."niri/config.kdl" = {
    source = ./config/niri/config.kdl;
    force = true; # на случай, если где-то остался не-Nix-managed файл
  };
}
