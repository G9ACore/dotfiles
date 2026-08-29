{
  config,
  pkgs,
  settings,
  terminals,
  ...
}: let
  term = terminals.${settings.terminal};
  termPkg = pkgs.${term.bin};

  render = import ../../lib/mkTemplate.nix;

  yazi-chooser = pkgs.writeShellScriptBin "yazi-chooser" (
    render ./config/termfilechooser/yazi-chooser.sh {
      terminal = "${termPkg}/bin/${term.bin}";
      yazi = "${pkgs.yazi}/bin/yazi";
    }
  );
in {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;

      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";

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
