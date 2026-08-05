{
  fileSystems."/home/dmitry/drives/gaming" = {
    device = "/dev/disk/by-uuid/20A1-C9BC";
    fsType = "exfat";
    options = [
      "rw" "uid=1000" "gid=100" "fmask=000" "dmask=00"
      "nofail"
      "noauto"
      "x-systemd.automount"        # монтировать при первом обращении к папке
      "x-systemd.device-timeout=5" # ждать устройство максимум 5 с, а не 90
      "x-systemd.idle-timeout=120" # отмонтировать через 2 мин простоя (опционально)
    ];
  };
}
