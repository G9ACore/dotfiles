#!/usr/bin/env bash
# Wrapper для xdg-desktop-portal-termfilechooser + Yazi
# Аргументы от termfilechooser:
#   $1 - multiple  (0/1)
#   $2 - directory (0/1)
#   $3 - save      (0/1)
#   $4 - path      (предложенный путь/директория)
#   $5 - out       (файл, куда записать результат)

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

# Очистить выходной файл
: > "$out"

# Собрать аргументы для Yazi
yazi_args=()
yazi_args+=(--chooser-file="$out")

# Если сохранение — можно добавить подсказку через имя файла
if [ "$save" = "1" ]; then
    # Yazi не имеет нативного "save dialog",
    # но --chooser-file работает и для выбора пути
    :
fi

# Запустить Yazi в терминале (замените foot на ваш терминал)
@terminal@ --app-id=yazi-chooser -- yazi "${yazi_args[@]}" "$path"

# Проверить, что файл не пуст (пользователь что-то выбрал)
if [ ! -s "$out" ]; then
    exit 1  # Отмена
fi

exit 0
