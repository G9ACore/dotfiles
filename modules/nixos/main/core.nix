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

      # при высокой задержке (RTT) до сервера, характерной для ДВ
      http-connections = 2;

      # Устойчивость к нестабильному каналу
      connect-timeout = 15;
      compress-build-log = true;
      stalled-download-timeout = 300;
      download-attempts = 10;
      fallback = true; # если кэш недоступен — собирать локально, не вставать колом
      keep-going = true; # не прерывать всю сборку из-за одной ошибки загрузки

      # Кэш метаданных отсутствующих путей — не долбить сервер повторно
      narinfo-cache-negative-ttl = 3600;

      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };

    optimise.automatic = true;

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
    aria2
    curl
    file
    unzip
    neovim
    ethtool
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

  boot.kernel.sysctl = {
    # Включаем TCP BBR
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";

    # Оптимизация TCP-стека для слабого интернета
    "net.ipv4.tcp_slow_start_after_idle" = 0; # Не замедляться после паузы
    "net.ipv4.tcp_mtu_probing" = 1; # Автоматическая подстройка MTU
    "net.ipv4.tcp_fastopen" = 3; # Ускорение установки соединений
    "net.core.rmem_max" = 16777216; # Увеличить буферы приёма
    "net.core.wmem_max" = 16777216; # Увеличить буферы передачи
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_window_scaling" = 1; # Масштабирование окна TCP
    "net.ipv4.tcp_timestamps" = 1; # Временные метки для PAWS
    "net.ipv4.tcp_sack" = 1; # Selective ACK для быстрого восстановления
    "net.ipv4.tcp_fack" = 1; # Forward ACK
    "net.ipv4.tcp_ecn" = 1; # Explicit Congestion Notification
  };

  # Swap for more "RAM"
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
