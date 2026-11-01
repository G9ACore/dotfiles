{...}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/main/default.nix

    # Хост-специфичные модули
    ../../modules/nixos/additional/default.nix
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

  boot = {
    resumeDevice = "/dev/disk/by-uuid/f3a84407-f306-43f3-a792-189820bb00cf";
    kernelParams = [
      "resume_offset=1277952"
    ];
  };

  system.stateVersion = "26.11";
}
