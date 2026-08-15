{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/default.nix

    # Host-specific modules
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/vpn.nix
    ../../modules/nixos/kdeconnect.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/shell.nix
    ../../modules/nixos/xdg.nix
    ../../modules/nixos/secrets.nix
  ];

  networking.hostName = "G9ACore";

  # Специфика ноутбука
  # TODO: Вынести bluetooth в отдельный файл
  # services.tlp.enable = true;

  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
}
