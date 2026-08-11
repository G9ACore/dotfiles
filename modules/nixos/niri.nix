{ pkgs, inputs, config, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # Дисплейный менеджер
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "dmitry";
      };
    };
  };

  systemd.user.services.niri.enableDefaultPath = false;

  # Переменные окружения для Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";      # Electron под Wayland
    MOZ_ENABLE_WAYLAND = "1";  # Firefox
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
  };
}
