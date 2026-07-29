{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware.nix
    ../../modules/nixos/default.nix
  ];

  networking.hostName = "laptop";

  # Специфика ноутбука
  # TODO: Вынести bluetooth в отдельный файл
  # services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
