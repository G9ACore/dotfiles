{pkgs, ...}: {
  home.packages = with pkgs; [
    udiskie
    ntfs3g
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";

    settings = {
      program_options = {
        file_manager = "${pkgs.yazi}/bin/yazi";
        automount = true;
        notify = true;
      };
    };
  };
}
