{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/fonts.nix
  ];

  networking.hostName = "laptop";

  # Специфика ноутбука
  # TODO: Вынести bluetooth в отдельный файл
  services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
