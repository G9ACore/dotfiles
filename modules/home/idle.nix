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
    systemdTargets = [ "graphical-session.target" ];

    timeouts = [
      {
        timeout = 295; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 450;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
	command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
	command = display "on";
      }
      {
        event = "lock";
	command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
	command = display "on";
      }
    ];
  };
}
