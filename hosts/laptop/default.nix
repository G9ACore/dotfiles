{ config, pkgs, inputs, ... }:
{
  # Хост-специфичные модули
  imports = [
    ./hardware.nix
    ../../modules/nixos/gaming.nix  # На VM не нужен
  ];

  networking.hostname = "laptop";

  # Специфика ноутбука
  services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
