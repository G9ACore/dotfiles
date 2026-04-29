{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  # Zen как браузер по умолчанию
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
    };
  };
}