{
  pkgs,
  config,
  ...
}: let
  render = import ../../lib/mkTemplate.nix;
  c = config.lib.stylix.colors.withHashtag;
in {
  xdg.configFile."swaync/style.css".text = render ./config/swaync/style.css {
    base00 = c.base00;
    base01 = c.base01;
    base02 = c.base02;
    base03 = c.base03;
    base04 = c.base04;
    base05 = c.base05;
    base08 = c.base08;
    base0D = c.base0D;
  };
  xdg.configFile."swaync/config.json".source = ./config/swaync/config.json; # тут цветов нет, не трогаем

  home.packages = with pkgs; [
    libnotify
  ];

  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notification Center";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };
}
