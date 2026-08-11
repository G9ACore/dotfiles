{
  pkgs,
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};
in {
  xdg.configFile."fuzzel/fuzzel.ini".text =
    builtins.replaceStrings
    ["@terminal_prefix@"]
    [term.prefix]
    (builtins.readFile ./config/fuzzel/fuzzel.ini);
}
