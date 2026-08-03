{ pkgs, inputs, config, ... }:
{
  programs.niri.enable = true; 

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

  # XDG порталы — нужны для скриншотов, скринкаста, file picker
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

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
