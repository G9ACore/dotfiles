{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.3:0.3";
      clock = true;
      timestr = "%H:%M";
      datestr = "%A, %d %B";

      indicator = true;
      indicator-radius = 125;
      indicator-thickness = 10;
      font = "JetBrainsMono Nerd Font Mono";
      font-size = 24;

      show-failed-attempts = true;
      indicator-idle-visible = false;
      fade-in = "0.3";
      # *-color ключи не пишем — их доклеит stylix через lib.mkDefault
    };
  };
}
