{ pkgs, ... }:
{
  # Зависимости для niri окружения
  home.packages = with pkgs; [
    fuzzel          # Лаунчер приложений
    swaylock        # Экран блокировки
    swayidle        # Автоблокировка
    wl-clipboard    # Буфер обмена
    cliphist        # История буфера обмена
    grimblast       # Скриншоты
    mako            # Уведомления
    playerctl       # Управление медиа
    brightnessctl   # Яркость
  ];

  # Конфиг Niri
  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us,ru"
          options "grp:alt_shift_toggle"
        }
      }
      touchpad {
        tap
        natural-scroll
        accel-speed 0.2
      }
    }

    layout {
      gaps 8
      focus-ring {
        width 2
        active-color "#89b4fa"
        inactive-color "#313244"
      }
      border { off }
    }

    window-rule {
      geometry-corner-radius 8
      clip-to-geometry true
    }

    binds {
      Mod+Return { spawn "kitty"; }
      Mod+Space  { spawn "fuzzel"; }
      Mod+Q      { close-window; }

      Mod+H { focus-column-left; }
      Mod+L { focus-column-right; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }

      Mod+Shift+H { move-column-left; }
      Mod+Shift+L { move-column-right; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }

      Mod+Shift+1 { move-window-to-workspace 1; }
      Mod+Shift+2 { move-window-to-workspace 2; }
      Mod+Shift+3 { move-window-to-workspace 3; }
      Mod+Shift+4 { move-window-to-workspace 4; }
      Mod+Shift+5 { move-window-to-workspace 5; }

      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+O { toggle-overview; }

      Print { screenshot; }
      Mod+Print { screenshot-window; }

      Mod+Shift+E { quit; }
      Mod+Shift+P { power-off-monitors; }

      XF86AudioRaiseVolume  { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
      XF86AudioLowerVolume  { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
      XF86AudioMute         { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
      XF86MonBrightnessUp   { spawn "brightnessctl" "set" "5%+"; }
      XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
    }

    spawn-at-startup "mako"
    spawn-at-startup "cliphist" "wipe"
  '';

  # Mako — уведомления
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    borderRadius = 8;
    padding = "12";
    margin = "8";
    # Цвета подтянет Stylix
  };

  # Swayidle — автоблокировка через 5 минут
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "niri msg action power-off-monitors"; }
    ];
  };
}