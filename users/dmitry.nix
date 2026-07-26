{ inputs, pkgs, lib, ... }:
{
  imports = [ ../modules/home/default.nix ];

  home = {
    username = lib.mkForce "dmitry";
    homeDirectory = lib.mkForce "/home/dmitry";
    stateVersion = "25.05";
  };
}
