{lib, ...}: {
  imports = [
    ../modules/home/default.nix

    ../modules/home/gaming.nix
    ../modules/home/minecraft.nix
    ../modules/home/shell.nix
    ../modules/home/obsidian.nix
    ../modules/home/development.nix
    ../modules/home/packages.nix
    ../modules/home/obs.nix
  ];

  home = {
    username = lib.mkForce "dmitry";
    homeDirectory = lib.mkForce "/home/dmitry";
    stateVersion = "25.05";
  };
}
