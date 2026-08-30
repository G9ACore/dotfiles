{
  pkgs,
  config,
  ...
}: let
  # Lock command
  lock = "${config.programs.swaylock.package}/bin/swaylock -f";
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
in {
  services.swayidle = {
    enable = true;
    systemdTargets = ["graphical-session.target"];

    timeouts = [
      {
        timeout = 295;
        command = "${pkgs.libnotify}/bin/notify-send -h boolean:transient:true -t 5000 'Locking in 5 seconds'";
      }
      {
        timeout = 300; # 5 минут
        command = lock;
      }
      {
        timeout = 420; # 7 минут
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 600; # 10 минут
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = {
      before-sleep = (display "off") + "; " + lock;
      after-resume = display "on";
      lock = (display "off") + "; " + lock;
      unlock = display "on";
    };
  };
}
