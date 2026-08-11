{
  config,
  pkgs,
  ...
}: {
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
    zip
    lsof
  ];

  programs.home-manager.enable = true;
}
