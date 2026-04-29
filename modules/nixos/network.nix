{ ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];  # SSH если нужен
    };
  };

  # mDNS — чтобы находить устройства в локалке по имени
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}