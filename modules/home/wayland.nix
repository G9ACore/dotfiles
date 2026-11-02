{pkgs, ...}: {
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [
    # Буфер обмена и его утилиты
    wl-clipboard
    wl-clip-persist
    wlr-randr

    # Ярксоть
    brightnessctl

    # Аудио
    playerctl
    helvum

    # Утилита мусорки
    trash-cli

    # Просмотр размера папок/файлов
    gdu

    imv
  ];
}
