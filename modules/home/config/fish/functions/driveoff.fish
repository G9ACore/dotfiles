if test (count $argv) -eq 0
    echo "Использование: driveoff <имя_папки_в_drives>"
    return 1
end

set name $argv[1]
set mountpoint "$HOME/drives/$name"
set unit (systemctl list-units --type=automount --no-legend --plain | string match -r "\S*drives-$name\.automount" | head -n1)

sudo umount -R "$mountpoint" 2>/dev/null

if test -n "$unit"
    sudo systemctl stop "$unit"
    echo "Отмонтировано и юнит остановлен: $name"
else
    echo "Отмонтировано: $name (юнит не найден, возможно уже остановлен)"
end
