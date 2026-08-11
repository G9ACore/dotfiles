# Скрытие лишних пунктов из fuzzel (и любого другого XDG-лаунчера)
#
# У fuzzel нет встроенного чёрного списка приложений. `filter-desktop=yes`
# в fuzzel.ini уберёт то, что явно помечено OnlyShowIn/NotShowIn под другое DE,
# но обычно "Громкость" (pavucontrol) и "Настройки Qt5" (qt5ct) под это не
# попадают — они показываются всем.
#
# Рабочий способ: создать в ~/.local/share/applications/ файл с ТЕМ ЖЕ
# Desktop File ID (тем же именем файла), что и у системного, и поставить
# NoDisplay=true. Пользовательская копия по спецификации XDG перекрывает
# системную для показа в меню, но сама программа продолжает работать
# как обычно, если её всё же запустить напрямую.
#
# 1. Найди точный ID нужных .desktop файлов:
#    grep -rl "Громкость\|Volume Control" \
#      /run/current-system/sw/share/applications \
#      ~/.nix-profile/share/applications 2>/dev/null
#    grep -rl "Qt5" \
#      /run/current-system/sw/share/applications \
#      ~/.nix-profile/share/applications 2>/dev/null
#
# 2. Имя файла без .desktop подставь ниже как имя атрибута.
#    Например если нашёл pavucontrol.desktop и qt5ct.desktop:
{...}: {
  xdg.desktopEntries = {
    pavucontrol = {
      name = "Pavucontrol";
      exec = "pavucontrol";
      noDisplay = true;
    };
    qt5ct = {
      name = "Qt5 Settings";
      exec = "qt5ct";
      noDisplay = true;
    };
    # добавляй сюда любые другие ID, которые захочешь скрыть
  };
}
