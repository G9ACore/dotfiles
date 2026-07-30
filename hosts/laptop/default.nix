{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware.nix
    ../../modules/nixos/default.nix

    # Host-specific modules
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/vpn.nix
    ../../modules/nixos/kdeconnect.nix
  ];

  networking.hostName = "G9ACore";

  # Специфика ноутбука
  # TODO: Вынести bluetooth в отдельный файл
  # services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
