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
  };
}
