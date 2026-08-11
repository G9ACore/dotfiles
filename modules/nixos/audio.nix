{pkgs, ...}: {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Нужно для Wine/Steam
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
