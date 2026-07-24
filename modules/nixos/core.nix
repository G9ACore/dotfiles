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

  # Консольный шрифт
  console = {
    font = "Lat2-Terminus16";
    keyMap = "ru";
  };

  # Базовые системные пакеты
  environment.systemPackages = with pkgs; [
    git
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
  nixpkgs.config.allowUnfree = true;

  # Загрузчик
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
