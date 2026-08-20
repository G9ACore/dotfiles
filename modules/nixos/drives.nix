{lib, ...}: let
  mkDrive = {
    uuid,
    # mountPoint,
    fsType ? "ntfs3",
    extraOptions ? [],
  }: {
    device = "/dev/disk/by-uuid/${uuid}";
    inherit fsType;
    options =
      [
        "rw"
        "user"
        "exec"
        "nofail"
        "noauto"
	"windows_names"
        "x-systemd.automount"
        "x-systemd.device-timeout=5"
        "x-systemd.idle-timeout=120"
      ]
      ++ (
        if builtins.elem fsType ["ntfs3" "exfat" "vfat"]
        then ["uid=1000" "gid=1000" "umask=000"]
        else []
      )
      ++ extraOptions;
  };
in {
  # Чтобы искать диски -> lsblk -f
  fileSystems = {
    "/home/dmitry/drives/games" = mkDrive {
      uuid = "149424719424580E";
    };
    "/home/dmitry/drives/data" = mkDrive {
      uuid = "DE761D31761D0C41";
    };
    "/home/dmitry/drives/extra" = mkDrive {
      uuid = "8A7811DB7811C6BB ";
    };
  };
}
