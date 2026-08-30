{
  settings,
  terminals,
  config,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;

  term = terminals.${settings.terminal};
  render = import ../../lib/mkTemplate.nix;
in {
  xdg.configFile."niri/config.kdl" = {
    text = render ./config/niri/config.kdl {
      base03 = c.base03;
      base0D = c.base0D;
      base0F = c.base0F;

      terminal_bin = term.bin;
      terminal_exec_yazi = term.exec "yazi";

      latitude = settings.wlsnt.latitude;
      longitude = settings.wlsnt.longitude;
      day_t = settings.wlsnt.day_t;
      night_t = settings.wlsnt.night_t;
    };
    force = true;
  };
}
