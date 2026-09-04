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

      # Параллелизм
      max-jobs = "auto";
      cores = 0;

      # Больше параллельных HTTP-соединений к кэшу — сильно помогает
      # при высокой задержке (RTT) до сервера, характерной для ДВ
      http-connections = 50;

      # Устойчивость к нестабильному каналу
      connect-timeout = 10;
      stalled-download-timeout = 90;
      download-attempts = 5;
      fallback = true; # если кэш недоступен — собирать локально, не вставать колом
      keep-going = true; # не прерывать всю сборку из-за одной ошибки загрузки

      # Кэш метаданных отсутствующих путей — не долбить сервер повторно
      narinfo-cache-negative-ttl = 3600;

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
    file
    unzip
    neovim
    pciutils # lspci
    usbutils # lsusb
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10; # сколько поколений показывать в списке
        consoleMode = "max"; # или "keep" — влияет на разрешение текста меню
      };
      efi.canTouchEfiVariables = true;
      timeout = 0; # не показывать меню вообще, грузить дефолт сразу
    };

    kernelParams = ["quiet" "systemd.show_status=false" "rd.systemd.show_status=false" "rd.udev.log_level=3"];

    consoleLogLevel = 3;
    initrd.verbose = false;

    supportedFilesystems = ["ext4" "exfat" "ntfs"];
  };

  boot.kernelModules = ["tcp_bbr" "sch_cake"];
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
  boot.kernel.sysctl."net.core.default_qdisc" = "cake";
  boot.kernel.sysctl."net.ipv4.tcp_slow_start_after_idle" = 0;

  # Swap for more "RAM"
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
