{
  config,
  pkgs,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = ["enp5s0"];
      allowedTCPPortRanges = [
        {
          from = 27015;
          to = 27050;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 27000;
          to = 27050;
        }
      ];
      allowedUDPPorts = [4380 27031 27036];
    };

    nameservers = ["1.1.1.1" "9.9.9.9" "127.0.0.1"];
  };
  networking.firewall.extraCommands = ''
    iptables -t mangle -A OUTPUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
  '';

  #services.udev.extraRules = ''
  #  ACTION=="add", SUBSYSTEM=="net", NAME=="enp5s0", RUN+="${pkgs.ethtool}/bin/ethtool -K enp5s0 tso off gso off gro off lro off"
  #'';
  # mDNS — чтобы находить устройства в локалке по имени
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.dnsmasq = {
    enable = false;
    settings = {
      cache-size = 1000;
      no-resolv = true;
      server = ["1.1.1.1" "8.8.8.8" "0.0.0.0"]; # Или DNS вашего VPN-провайдера
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "false";
      DNSOverTLS = "opportunistic";
    };
  };
}
