{ pkgs, ... }:
{
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;  # Gamescope для лучшей совместимости
  };

  # GameMode — оптимизирует CPU/GPU во время игры
  programs.gamemode.enable = true;

  # 32-битные библиотеки для Wine, Minecraft и старых игр
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    lutris          # Запуск игр не из Steam
    heroic          # Epic Games / GOG
    bottles         # Wine-контейнеры
    mangohud        # Оверлей FPS/температур
    protonup-qt     # Обновление Proton GE
    glxinfo         # диагностика OpenGL
  ];
}