{
  pkgs,
  lib,
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};

  # File extension depends on the selected terminal
  pathToConfig = "${terminals.${settings.terminal}.bin}/${terminals.${settings.terminal}.bin}.ini";
in {
  programs.${term.bin} = {
    enable = true;
  };

  xdg.configFile."${pathToConfig}".source =
    lib.mkForce ./config/${pathToConfig};
}
