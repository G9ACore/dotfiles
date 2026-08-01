{ pkgs, ... }:
{
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [
    # Screenshots
    grim
    slurp

    # Display lock
    swaylock

    # Wayland utilities
    wl-clipboard
    wlr-randr

    # Wallpaper
    swaybg

    # Launcher
    fuzzel

    # File manager
    yazi

    # Audio
    pavucontrol

    # Network
    networkmanagerapplet

    # Brightness
    brightnessctl

    # Notifications
    mako

    # Bluetooth
    blueman

    # Music
    playerctl

    # Switch power profiles
    power-profiles-daemon

    waybar
  ];
}
