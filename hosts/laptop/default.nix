{ config, pkgs, inputs, ... }:
{
  imports = [ ./hardware.nix ];

  networking.hostName = "nixlaptop";

  # Хост-специфичные модули
  imports = [
    ./hardware.nix
    ../../modules/nixos/gaming.nix  # На VM не нужен
  ];

  # Специфика ноутбука
  services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}