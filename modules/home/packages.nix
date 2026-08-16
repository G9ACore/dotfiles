{pkgs, ...}: {
  home.packages = with pkgs; [
    onlyoffice-desktopeditors

    teamspeak6-client
  ];
}
