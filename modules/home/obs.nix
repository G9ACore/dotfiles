{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture # захват аудио конкретных приложений через pipewire
      obs-vkcapture              # прямой Vulkan/OpenGL захват игр — быстрее и стабильнее портала
    ];
  };
}
