{settings, terminals, lib, ...}: let
  term = terminals.${settings.terminal};
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "JetBrainsMono Nerd Font Mono:weight=bold:size=12";
        icon-theme = "Adwaita";
        terminal = term.prefix;
        layer = "overlay";
        width = 40;
        lines = 8;
        horizontal-pad = 24;
        vertical-pad = 16;
        inner-pad = 10;
        line-height = 26;
        filter-desktop = "yes";
      };
      border = {
        width = 2;
        radius = 20;
      };
      dmenu.exit-immediately-if-empty = "yes";
      # секцию [colors] не пишем — её сгенерирует stylix
    };
  };
}
