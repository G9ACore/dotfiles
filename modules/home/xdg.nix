{ config, ... }:
{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;

      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/pics";
      videos = "${config.home.homeDirectory}/vids";

      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
      projects = null;
    };

    # yazi — TUI-программа, xdg-open не умеет запускать такие напрямую,
    # поэтому оборачиваем в alacritty. Это отдельный .desktop-файл,
    # который Firefox/PrismLauncher увидят как "Yazi" при открытии папки.
    desktopEntries.yazi = {
      name = "Yazi";
      comment = "Терминальный файловый менеджер";
      exec = "alacritty -e yazi %f";
      terminal = false;
      type = "Application";
      mimeType = [ "inode/directory" ];
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];
      };
    };
  };
}
