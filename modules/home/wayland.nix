{pkgs, ...}: {
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [
    # Screenshots
    grim
    slurp
    swappy

    # Wayland utilities
    wl-clipboard
    wl-clip-persist
    cliphist
    wlr-randr

    # Wallpaper
    swaybg

    # Launcher
    fuzzel

    # Network
    networkmanagerapplet

    # Brightness
    brightnessctl

    # Bluetooth
    blueman

    # Audio
    playerctl
    helvum
    pavucontrol

    # Trash utilite
    trash-cli

    # File/Dirs size viewer
    gdu
  ];

  xdg.configFile."swappy/config".source = ./config/swappy/config;
}
