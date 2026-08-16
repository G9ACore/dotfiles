set old_pwd $PWD

set mnt (find /run/user/(id -u)/gvfs -maxdepth 1 -type d -name 'mtp:host=*' 2>/dev/null | head -n1)

if test -z "$mnt"
  set vol (gio mount -li 2>/dev/null | grep -oP 'activation_root=\Kmtp://\S+' | head -n1)
  if test -z "$vol"
    echo "Телефон не найден. Проверь USB-кабель и режим 'Передача файлов' на телефоне."
    return 1
  end
  gio mount "$vol"
  set mnt (find /run/user/(id -u)/gvfs -maxdepth 1 -type d -name 'mtp:host=*' 2>/dev/null | head -n1)
end

if test -z "$mnt"
  echo "Не удалось смонтировать телефон."
  return 1
end

y "$mnt"

cd $old_pwd

if test -n "$mnt"
  gio mount -u "$mnt" 2>/dev/null
  echo "Устройство успешно отмонтировано."
end
