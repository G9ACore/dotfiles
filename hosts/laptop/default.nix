{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware.nix
    ../modules/nixos/core.nix
  ];

  networking.hostname = "laptop";

  # Специфика ноутбука
  services.tlp.enable = true;       # Управление питанием
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
