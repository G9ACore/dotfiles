{ pkgs, ... }:
let
  css = ./config/waybar/css;
in
{
  home = {
    packages = with pkgs; [
      waybar
      swaynotificationcenter
      pavucontrol
      jq
    ];

    file.".config/waybar/scripts/battery-status.sh" = {
      source = ./config/waybar/scripts/battery-status.sh;
      executable = true;
    };

    file.".config/waybar/scripts/language.sh" = {
      source = ./config/waybar/scripts/language.sh;
      executable = true;
    };
  };

  programs.waybar = {
    enable = true;

    style =
      builtins.concatStringsSep "\n" [
        (builtins.readFile "${css}/colors.css")
        (builtins.readFile "${css}/style.css")
      ];

    settings = [
     (builtins.fromJSON (builtins.readFile ./config/waybar/config.jsonc))
    ];

    # To make the waybar open when you log in
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };
}
