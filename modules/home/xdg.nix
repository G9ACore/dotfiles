{
  config,
  pkgs,
  ...
}: let
  yazi-chooser = pkgs.writeShellScriptBin "yazi-chooser" (
    builtins.replaceStrings
    ["@alacritty@" "@yazi@"]
    ["${pkgs.alacritty}/bin/alacritty" "${pkgs.yazi}/bin/yazi"]
    (builtins.readFile ./config/termfilechooser/yazi-chooser.sh)
  );
in {
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
      mimeType = ["inode/directory"];
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["yazi.desktop"];
      };
    };
  };

  # Пакеты с systemd user units для Home Manager
  systemd.user.packages = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-termfilechooser
    pkgs.xdg-desktop-portal-gtk
  ];

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yazi-chooser}/bin/yazi-chooser
    default_dir=/home/dmitry
    open_mode=suggested
    save_mode=last
  '';
}
