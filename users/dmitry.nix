{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/home/default.nix

    ../modules/home/gaming.nix
    ../modules/home/minecraft.nix
    ../modules/home/aliases.nix
    ../modules/home/obsidian.nix
    ../modules/home/packages.nix
  ];

  home = {
    username = lib.mkForce "dmitry";
    homeDirectory = lib.mkForce "/home/dmitry";
    stateVersion = "25.05";
  };
}
