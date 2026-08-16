{
  pkgs,
  settings,
  ...
}: {
  # Nix settings
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Locale
  time.timeZone = settings.timeZone;
  i18n = {
    defaultLocale = "ru_RU.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Base system packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    btop
    file
    unzip
    neovim
    pciutils # lspci
    usbutils # lsusb
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = ["quiet" "systemd.show_status=false" "rd.systemd.show_status=false" "rd.udev.log_level=3"];

    consoleLogLevel = 3;
    initrd.verbose = false;

    supportedFilesystems = ["ext4" "exfat" "ntfs"];
  };

  # Swap for more "RAM"
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
