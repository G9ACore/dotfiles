{inputs, ...}: let
  # Вспомогательная функция для расширений с Firefox Add-ons
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    (extension "foxy-proxy" "foxyproxy@eric.h.jung")
    (extension "dark-reader" "4addon@darkreader.org")
    (extension "adGuard" "adguardadblocker@adguard.com")
  ];
in {
  # 1. Устанавливаем сам Zen Browser через Home Manager
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  # (Home Manager умеет генерировать policies.json в ~/.mozilla/native-messaging-hosts или профиле)
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Корпоративные политики (Аналог extraPolicies)
    policies = {
      DisableTelemetry = true;
      ExtensionSettings = builtins.listToAttrs extensions;

      SearchEngines = {
        Default = "Google";
        Add = [
          {
            Name = "nixpkgs packages";
            URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
            IconURL = "https://wiki.nixos.org/favicon.ico";
            Alias = "@np";
          }
          {
            Name = "NixOS options";
            URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
            IconURL = "https://wiki.nixos.org/favicon.ico";
            Alias = "@no";
          }
          {
            Name = "NixOS Wiki";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            IconURL = "https://wiki.nixos.org/favicon.ico";
            Alias = "@nw";
          }
          {
            Name = "noogle";
            URLTemplate = "https://noogle.dev/q?term={searchTerms}";
            IconURL = "https://noogle.dev/favicon.ico";
            Alias = "@ng";
          }
        ];
      };
    };

    # 3. Настройка профиля
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;

        # --- Оптимизация для слабого интернета ---
        "network.prefetch-next" = false; # Отключить предзагрузку ссылок
        "network.dns.disablePrefetch" = true; # Отключить предзагрузку DNS
        "network.http.keep-alive.timeout" = 300; # Держать соединение открытым дольше (5 мин)
        "browser.sessionstore.interval" = 600000; # Автосохранение сессии раз в 10 мин (экономия I/O)
        "media.autoplay.default" = 5; # Блокировать автозапуск аудио/видео

        # --- Дополнительные твики для экономии трафика ---
        "image.animation_mode" = "none"; # Отключить анимацию GIF (экономит трафик и CPU)
        "browser.cache.disk.enable" = true; # Включить кэш на диск
        "browser.cache.disk.max_entry_size" = 50000; # Макс размер кэшируемого файла 50 МБ
        "browser.cache.memory.enable" = true; # Кэш в ОЗУ
        "browser.cache.memory.capacity" = 65536; # 64 МБ кэша в ОЗУ

        # --- Отключение телеметрии и лишнего фона ---
        "browser.safebrowsing.malware.enabled" = false; # Отключить Google SafeBrowsing (тратит трафик)
        "browser.safebrowsing.phishing.enabled" = false;
        "toolkit.telemetry.enabled" = false;

        # Для быстрого скроллинга при помощи нажатия колёсика мыши
        "general.autoScroll" = true;
        # Обязательно для использования userChrome.css
        # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Чтобы уведомления от браузера не дублировались
        "widget.use-xdg-desktop-portal.notification" = false;

        # Пример других удобных опций:
        "browser.tabs.warnOnClose" = false;
        "browser.download.panel.shown" = true;
      };

      # Гибкая кастомизация интерфейса через userChrome.css
      userChrome = ''
        /* Ваши кастомные CSS-стили для интерфейса Zen Browser */
        /* Например, скрыть или уменьшить элементы интерфейса: */
        #nav-bar {
          /* background-color: transparent !important; */
        }
      '';

      # Стили для веб-страниц через userContent.css
      userContent = ''
        /* Стили, применяемые к страницам (например, about:blank) */
      '';
    };
  };

  # 4. Прямое управление любыми файлами профиля
  # Если вам нужно прокинуть свой файл кастомных горячих клавиш или настроек Zen:
  # home.file.".zen/default/zen-keyboard-shortcuts.json".source = ./zen-shortcuts.json;
}
