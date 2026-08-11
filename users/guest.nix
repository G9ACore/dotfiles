{pkgs, ...}: {
  imports = [
    ../modules/home/core.nix
    ../modules/home/stylix.nix
    ../modules/home/terminal.nix
    # Без gaming, без noctalia
  ];

  home = {
    username = "guest";
    homeDirectory = "/home/guest";
    stateVersion = "25.05";
  };
}
