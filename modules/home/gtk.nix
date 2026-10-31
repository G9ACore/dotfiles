{pkgs, ...}: {
  gtk = {
    enable = true;

    # Важно: пока stylix.targets.gtk.enable = true, stylix сам ставит
    # иконки GTK (сгенерированный Colloid/Papirus из своей палитры) и
    # переопределяет эту настройку через mkForce. Чтобы выбрать тему вручную,
    # отключите цель: stylix.targets.gtk.enable = false (см. home/stylix.nix).
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  # Papirus полон только для иконок приложений/каталогов; many tray-иконки
  # (StatusNotifier) берутся из hicolor + librsvg (SVG-иконки вроде Telegram/Spotify).
  # Убедитесь, что в systemPackages есть: papirus-icon-theme, hicolor-icon-theme, librsvg.
}
