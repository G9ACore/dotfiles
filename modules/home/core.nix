{ config, pkgs, ... }:
{
  # Base-user packages
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    eza
    fzf
    fastfetch
    p7zip
    unrar
  ];

  programs.home-manager.enable = true;

  home.sessionVariables.EDITOR = "nvim";
}
