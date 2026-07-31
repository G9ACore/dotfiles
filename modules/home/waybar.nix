{ pkgs, ... }:
{
  home.packages = [
    pkgs.waybar
  ];
  
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  home.file = {
    ".config/waybar/config.jsonc" = {
      source = ./config/waybar/config.jsonc; # Путь к файлу относительно текущего .nix файла
      force = true; # Принудительно перезаписывать файл при конфликтах
    };
    ".config/waybar/style.css" = {
      source = ./config/waybar/style.css; # Путь к файлу относительно текущего .nix файла
      force = true; # Принудительно перезаписывать файл при конфликтах
    };
  };
}
