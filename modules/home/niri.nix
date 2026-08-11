{
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};
in {
  xdg.configFile."niri/config.kdl" = {
    text =
      builtins.replaceStrings
      ["@terminal_bin@" "@terminal_exec_yazi@"]
      [term.bin (term.exec "yazi")]
      (builtins.readFile ./config/niri/config.kdl);
    force = true; # на случай, если где-то остался не-Nix-managed файл
  };
}
