{ pkgs, lib, ... }:
{
  # Nix настройки
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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

  # Локаль
  time.timeZone = "Europe/Moscow";
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

  # Базовые системные пакеты
  environment.systemPackages = with pkgs; [
    wget
    curl
    btop
    file
    unzip
    neovim
    pciutils   # lspci
    usbutils   # lsusb
  ];

  # Разрешить не-свободные пакеты (нужно для Steam, драйверов)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "obsidian"
    "unrar"
    "nvidia-x11"
    "nvidia-settings"
    "nvidia-kernel-modules"
  ];

  # Загрузчик
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Disables kernel log messages on the console
    kernelParams = [ "quiet" "systemd.show_status=false" "rd.systemd.show_status=false" "rd.udev.log_level=3" ];
    
    # Hides systemd status messages during boot execution
    consoleLogLevel = 3;
    initrd.verbose = false;

    supportedFilesystems = [ "ext4" "exfat" "ntfs" ];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # Выделит виртуальный своп размером в половину вашей ОЗУ
  };
}
