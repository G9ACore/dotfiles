{ pkgs, ... }:
{
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  programs.xwayland.enable = true;

  # Включение игрового режима Feral GameMode
  programs.gamemode = {
    enable = true;
    enableRenice = true; # Позволяет менять приоритет процесса Java
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };


  # 32-битные библиотеки для Wine, Minecraft и старых игр
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    # lutris          # Запуск игр не из Steam
    # heroic          # Epic Games / GOG
    bottles         # Wine-контейнеры
    mangohud        # Оверлей FPS/температур
    protonup-qt     # Обновление Proton GE
    mesa-demos         # диагностика OpenGL
    xwayland-satellite
  ];
}
