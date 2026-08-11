{...}: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
    };
  };

  # mDNS — чтобы находить устройства в локалке по имени
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
