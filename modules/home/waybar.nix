{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    waybar

    # Athena использует их в кликах/модулях
    pavucontrol
    networkmanagerapplet
    blueman
    wl-clipboard

    wl-clip-persist
    cliphist
    wlr-randr

    # Нужен для notification/tray части Athena.
    # Можно убрать, если SwayNC у тебя не используется.
    swaynotificationcenter

    # Power profiles
    power-profiles-daemon
  ];

  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      targets = ["graphical-session.target"];
    };
  };

  xdg.configFile."waybar" = {
    source = ./config/waybar;
    recursive = true;
  };
}
