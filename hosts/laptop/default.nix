{...}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/default.nix

    # Хост-специфичные модули
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/vpn.nix
    ../../modules/nixos/power.nix
    ../../modules/nixos/kdeconnect.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/shell.nix
    ../../modules/nixos/xdg.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/unfree.nix
    ../../modules/nixos/team-comms.nix
  ];

  networking.hostName = "G9ACore";

  # Специфика ноутбука
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 18 * 1024; # в МиБ, подставлять >= RAM
    }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/f3a84407-f306-43f3-a792-189820bb00cf"; # UUID корневого раздела, где лежит swapfile

  system.stateVersion = "25.05";
}
