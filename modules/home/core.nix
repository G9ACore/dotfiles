{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Base-user packages
    ripgrep
    fd
    bat
    eza
    fzf
    fastfetch
    p7zip
    unrar

    # Wayland packages
    wl-clipboard
    grim
    slurp
    satty
    swaynotificationcenter
    waybar
    fuzzel
  ];  

  programs.home-manager.enable = true;
}
