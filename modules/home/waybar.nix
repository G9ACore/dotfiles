{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.waybar
  ];
  
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./config/waybar/style.css;
    settings = [
      (builtins.fromJSON (builtins.readFile ./config/waybar/config.jsonc))
    ];

    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };

  # home.file.".config/waybar/config.jsonc" = {
  #   source = ./config/waybar/config.jsonc; # Путь к файлу относительно текущего .nix файла
  #   force = true; # Принудительно перезаписывать файл при конфликтах
  # };
}
