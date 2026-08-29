{
  config,
  pkgs,
  ...
}: let
  render = import ../../lib/mkTemplate.nix;
  c = config.lib.stylix.colors.withHashtag;
  colorVars = {
    base00 = c.base00;
    base01 = c.base01;
    base02 = c.base02;
    base03 = c.base03;
    base04 = c.base04;
    base05 = c.base05;
    base08 = c.base08;
    base0A = c.base0A;
    base0B = c.base0B;
    base0D = c.base0D;
    base0E = c.base0E;
    base0F = c.base0F;
    base09 = c.base09;
  };

  colorsCss = pkgs.writeText "colors.css" (render ./config/waybar/tokens/colors.css colorVars);
  stateCss = pkgs.writeText "state.css" (render ./config/waybar/tokens/state.css colorVars);

  waybarConfig = pkgs.runCommand "waybar-config" {} ''
    mkdir -p $out
    cp -r ${./config/waybar}/. $out/
    chmod -R u+w $out
    cp ${colorsCss} $out/tokens/colors.css
    cp ${stateCss}  $out/tokens/state.css
  '';
in {
  home.packages = with pkgs; [
    waybar
    pavucontrol
    networkmanagerapplet
    blueman
    swaynotificationcenter
    power-profiles-daemon
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = ["graphical-session.target"];
    };
  };

  # home.packages, programs.waybar — без изменений

  xdg.configFile."waybar" = {
    source = waybarConfig;
    recursive = true;
  };
}
