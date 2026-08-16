if test (count $argv) -eq 0
    echo "Использование: driveon <имя_папки_в_drives>"
    return 1
end

set name $argv[1]
set unit (systemctl list-units --type=automount --all --no-legend --plain | string match -r "\S*drives-$name\.automount" | head -n1)

if test -n "$unit"
    sudo systemctl start "$unit"
end

y "$HOME/drives/$name"
