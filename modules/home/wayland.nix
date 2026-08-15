{pkgs, ...}: {
  # TODO: Раскидать все приложения по категориям: системные, под NiRi

  home.packages = with pkgs; [
    # Screenshots
    grim
    slurp
    swappy

    # Wallpaper
    swaybg

    # Launcher
    fuzzel

    # Brightness
    brightnessctl

    # Audio
    playerctl
    helvum

    # Trash utilite
    trash-cli

    # File/Dirs size viewer
    gdu
  ];

  xdg.configFile."swappy/config".source = ./config/swappy/config;
}
