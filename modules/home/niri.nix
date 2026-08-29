{
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};
  render = import ../../lib/mkTemplate.nix;
in {
  xdg.configFile."niri/config.kdl" = {
    text = render ./config/niri/config.kdl {
      terminal_bin = term.bin;
      terminal_exec_yazi = term.exec "yazi";
    };
    force = true;
  };
}
