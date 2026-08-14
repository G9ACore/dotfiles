{pkgs, ...}: {
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;

    extest.enable = true;
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
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # udev-правила для DualShock/DualSense и прочих Steam-совместимых геймпадов
    steam-hardware.enable = true;
    # виртуальные устройства ввода, нужны Steam Input для ремаппинга/gyro
    uinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # lutris          # Запуск игр не из Steam
    # heroic          # Epic Games / GOG
    bottles # Wine-контейнеры
    mangohud # Оверлей FPS/температур
    protonup-qt # Обновление Proton GE
    mesa-demos # диагностика OpenGL
    xwayland-satellite
  ];

  # на случай, если hid_playstation не подхватывается автоматически
  boot.kernelModules = ["hid_playstation"];
}
