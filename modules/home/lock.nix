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
      indicator-radius = 100;
      indicator-thickness = 10;
      font = "JetBrainsMono Nerd Font Mono";
      font-size = 24;

      inside-color = "1e1f25aa";
      ring-color = "44464f";
      text-color = "e2e2e9";
      line-color = "00000000";

      key-hl-color = "b0c6ff";
      bs-hl-color = "ffb4ab";

      inside-ver-color = "2e4578aa";
      ring-ver-color = "b0c6ff";
      text-ver-color = "d9e2ff";

      inside-wrong-color = "93000aaa";
      ring-wrong-color = "ffb4ab";
      text-wrong-color = "ffdad6";

      show-failed-attempts = true;
      indicator-idle-visible = false;
      fade-in = "0.3";
    };
  };
}
