{
  pkgs,
  config,
  ...
}: {
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # Дисплейный менеджер
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };

  # Для сохранения сессии (нужен для tuigreet)
  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];

  systemd.user.services.niri.enableDefaultPath = false;

  # Переменные окружения для Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron под Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    GTK_USE_PORTAL = "1";
  };
}
