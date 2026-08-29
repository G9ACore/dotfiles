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
        timeout = 895; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send -h boolean:transient:true -t 5000 'Locking in 5 seconds'";
      }
      {
        timeout = 900;
        command = lock;
      }
      {
        timeout = 1000;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 1800;
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
