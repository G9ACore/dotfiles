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
      options = "--delete-older-than 14d";
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
    htop
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
  ];

  # Загрузчик
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Disables kernel log messages on the console
    kernelParams = [ "quiet" "systemd.show_status=false" "rd.systemd.show_status=false" "rd.udev.log_level-3" ];
    
    # Hides systemd status messages during boot execution
    consoleLogLevel = 0;
    initrd.verbose = false;

    supportedFilesystems = [ "ext4" "exfat" ];
  };
}
