{ config, pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  networking.hostName = "vm";

  # VM-специфика
  virtualisation.virtualbox.guest.enable = true;
  # Без gaming модуля, без TLP

  system.stateVersion = "25.05";
}