{pkgs, ...}: {
  home.packages = [pkgs.udisks2];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };
}
