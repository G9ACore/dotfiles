{
  pkgs,
  lib,
  ...
}: {
  services.udev.extraRules = let
  mount = uuid: target: opts: ''
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="${uuid}", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --collect --options=${opts} $env{DEVNAME} ${target}"
    ACTION=="remove", ENV{ID_FS_UUID}=="${uuid}", RUN+="${pkgs.systemd}/bin/systemd-umount ${target}"
  '';
in lib.concatStrings [
    (mount "149424719424580E" "/home/dmitry/drives/games" "rw,uid=1000,gid=1000,umask=000,windows_names,sys_immutable,iocharset=utf8,")
    (mount "DE761D31761D0C41" "/home/dmitry/drives/data" "rw,uid=1000,gid=1000,umask=000,windows_names")
    (mount "8A7811DB7811C6BB" "/home/dmitry/drives/extra" "rw,uid=1000,gid=1000,umask=000,windows_names,sys_immutable,iocharset=utf8")
  ];
}
