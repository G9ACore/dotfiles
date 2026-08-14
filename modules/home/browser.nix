{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  # Вспомогательная функция для расширений с Firefox Add-ons
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    # (extension "ublock-origin" "uBlock0@raymondhill.net")
    # Дополнительные расширения добавлять сюда
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

      # Аналог вашего prefs из let-блока
      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;

        # Обязательно для использования userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

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
