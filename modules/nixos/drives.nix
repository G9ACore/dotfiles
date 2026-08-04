{ ... }:
{
  fileSystems."/home/dmitry/drives/gaming" = {
    device = "/dev/disk/by-uuid/20A1-C9BC";
    fsType = "exfat";
    options = [ "rw" "uid=1000" "gid=100" "fmask=000" "dmask=000" "nofail" ]; # "user" позволяет обычному пользователю читать/писать
  };
}
