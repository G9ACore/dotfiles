{ pkgs, ... }:
{
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [    # Screenshots
    grim
    slurp
    swappy

    # Display lock
    swaylock
    swayidle

    # Wayland utilities
    wl-clipboard
    wl-clip-persist
    cliphist
    wlr-randr

    # Wallpaper
    swaybg

    # Launcher
    fuzzel

    # File manager
    yazi

    # Network
    networkmanagerapplet

    # Brightness
    brightnessctl

    # Bluetooth
    blueman

    # Music
    playerctl
  ];

  xdg.configFile."swappy/config".source = ./config/swappy/config;
}
