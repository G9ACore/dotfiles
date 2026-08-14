{pkgs, ...}: {
  services.gvfs.enable = true; # автоопределение MTP-устройств
  services.udisks2.enable = true; # нужен gvfs'у для управления сменными носителями

  services.udev.packages = [pkgs.libmtp]; # 69-libmtp.rules — права на MTP-устройства для обычного юзера

  environment.systemPackages = with pkgs; [
    jmtpfs # ручное монтирование телефона в обычную папку
    android-file-transfer
  ];
}
