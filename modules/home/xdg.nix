{
  config,
  pkgs,
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};
  termPkg = pkgs.${term.bin};

  yazi-chooser = pkgs.writeShellScriptBin "yazi-chooser" (
    builtins.replaceStrings
    ["@terminal@" "@yazi@"]
    ["${termPkg}/bin/${term.bin}" "${pkgs.yazi}/bin/yazi"]
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

    desktopEntries.yazi = {
      name = "Yazi";
      comment = "Терминальный файловый менеджер";
      exec = term.exec "yazi %f";
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

  systemd.user.packages = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-termfilechooser
    pkgs.xdg-desktop-portal-gtk
  ];

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yazi-chooser}/bin/yazi-chooser
    default_dir=/home/${settings.primaryUser}
    open_mode=suggested
    save_mode=last
  '';
}
