{
  fileSystems."/home/dmitry/drives/gaming" = {
    device = "/dev/disk/by-uuid/149424719424580E";
    fsType = "ntfs3";
    options = [
      "rw" "uid=1000" "gid=1000" "umask=000" "user" "exec" "nofail" "noauto"
      "x-systemd.automount"        # монтировать при первом обращении к папке
      "x-systemd.device-timeout=5" # ждать устройство максимум 5 с, а не 90
      "x-systemd.idle-timeout=120" # отмонтировать через 2 мин простоя (опционально)
    ];
  };
}
