{ inputs, pkgs, ... }:
{
  imports = [
    ../modules/home/core.nix
    ../modules/home/stylix.nix
    ../modules/home/niri.nix
    ../modules/home/noctalia.nix
    ../modules/home/terminal.nix
    ../modules/home/zen-browser.nix
    ../modules/home/gaming.nix
    ../modules/home/minecraft.nix
  ];

  home = {
    username = "dmitry";
    homeDirectory = "/home/dmitry";
    stateVersion = "25.05";
  };

  # Пакеты только для этого пользователя
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}