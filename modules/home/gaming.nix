{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Уже установлено системно через modules/nixos/gaming.nix,
    # здесь только пользовательские утилиты
    ludusavi        # Резервное копирование сохранений игр
    discord         # Голосовой чат
  ];

  # GameMode активируется автоматически для Steam
  # MangoHud конфиг
  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    fps
    cpu_temp
    gpu_temp
    ram
    vram
    frame_timing=0
    position=top-left
    font_size=18
  '';
}