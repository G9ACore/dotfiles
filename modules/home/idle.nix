{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    timeouts = [
      {
        timeout = 300; # 5 минут бездействия — блокировка экрана
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600; # 10 минут бездействия — сон
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };
}
