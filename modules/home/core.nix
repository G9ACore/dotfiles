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

    glib

    python3
  ];

  programs.home-manager.enable = true;
}
