{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.waybar
  ];
  
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  home.file.".config/waybar/config.jsonc" = {
    source = ./config/waybar/config.jsonc; # Путь к файлу относительно текущего .nix файла
    force = true; # Принудительно перезаписывать файл при конфликтах
  };
}
