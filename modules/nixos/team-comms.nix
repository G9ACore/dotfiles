{
  # Teamspeak3 server
  services.teamspeak3 = {
    enable = false;
    openFirewall = false; # сам откроет нужные UDP/TCP порты
  };

  services.teamviewer.enable = true;
}
