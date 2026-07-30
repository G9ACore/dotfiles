{ config, ... }:
{
  xdg.configFile."niri/config.kdl".source =
    ./config/niri/config.kdl;

  home.file.".config/niri/config.kdl" = {
    source = ./dotfiles/niri-config.kdl; # Путь к файлу относительно текущего .nix файла
    force = true; # Принудительно перезаписывать файл при конфликтах
  };
}
