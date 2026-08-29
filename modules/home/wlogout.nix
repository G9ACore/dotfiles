{
  pkgs,
  config,
  ...
}: let
  render = import ../../lib/mkTemplate.nix;
  c = config.lib.stylix.colors.withHashtag;
in {
  home.packages = with pkgs; [wlogout];
  xdg.configFile."wlogout/layout".source = ./config/wlogout/layout.json;
  xdg.configFile."wlogout/style.css".text = render ./config/wlogout/style.css {
    base00 = c.base00;
    base01 = c.base01;
    base02 = c.base02;
    base04 = c.base04;
    base05 = c.base05;
    base08 = c.base08;
    base0D = c.base0D;
  };
}
