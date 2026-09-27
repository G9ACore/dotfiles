{pkgs, ...}: {
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [
    # Скриншоты
    grim
    slurp
    swappy

    # Буфер обмена и его утилиты
    wl-clipboard
    wl-clip-persist
    cliphist
    wlr-randr

    # Обои
    swaybg

    # Лаунчер
    fuzzel

    # Ярксоть
    brightnessctl
    wlsunset

    # Аудио
    playerctl
    helvum

    # Утилита мусорки
    trash-cli

    # Просмотр размера папок/файлов
    gdu

    imv
  ];

  xdg.configFile."swappy/config".source = ./config/swappy/config;

  home.file.".config/wallpaper.jpg".source =
    ../../assets/wallpapers/wallpaper.jpg;
}
