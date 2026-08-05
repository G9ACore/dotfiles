{ pkgs, lib, ... }:
{
  xdg.configFile."swaync/style.css".source = ./config/swaync/style.css;
  xdg.configFile."swaync/config.json".source = ./config/swaync/config.json;

  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notification Center";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
