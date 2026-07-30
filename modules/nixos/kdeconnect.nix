{ pkgs, ... }:
{
  # Enable KDE Connect service/daemon
  programs.kdeconnect.enable = true;

  # Open firewall ports required for device discovery and connection
  networking.firewall = rec {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}

