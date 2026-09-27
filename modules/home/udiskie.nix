{pkgs, ...}: {
  home.packages = with pkgs; [
    udisks2
    ntfs3g
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    tray = "auto";
    notify = true;
    settings = {
      device_config = [
        {
          id_uuid = "149424719424580E";
          mount_point = "/home/dmitry/Drives/games";
          options = ["rw" "exec" "uid=1000" "gid=1000" "iocharset=utf8"];
        }
        {
          id_uuid = "DE761D31761D0C41";
          mount_point = "/home/dmitry/Drives/data";
          options = ["rw" "exec" "uid=1000" "gid=1000" "umask=000" "iocharset=utf8"];
        }
        {
          id_uuid = "8A7811DB7811C6BB";
          mount_point = "/home/dmitry/Drives/extra";
          options = ["rw" "exec" "uid=1000" "gid=1000" "iocharset=utf8"];
        }
      ];
    };
  };
}
