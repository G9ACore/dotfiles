{...}: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
    };

    nameservers = ["1.1.1.1" "9.9.9.9"];
  };

  # mDNS — чтобы находить устройства в локалке по имени
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "false";
      DNSOverTLS = "opportunistic";
    };
  };
}
