{ pkgs, lib, ... }:
{
  # Nix настройки
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
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
    extraLocaleSettings.LC_TIME = "en_US.UTF-8";
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