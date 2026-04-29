{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;  # Нужно для Wine/Steam
    pulse.enable = true;
    jack.enable = true;        # Для аудиоработы если нужно
  };

  environment.systemPackages = with pkgs; [
    pavucontrol    # GUI микшер
    helvum         # Граф подключений Pipewire
  ];
}