{
  config,
  pkgs,
  ...
}: let
  inherit (builtins) readFile replaceStrings filter;
  inherit (pkgs.lib) optionalString;

  render = import ../../lib/mkTemplate.nix;
  c = config.lib.stylix.colors.withHashtag;

  # Палитра stylix -> подстановка в @baseXX@ внутри QML-шаблонов.
  colorVars = {
    base00 = c.base00;
    base01 = c.base01;
    base02 = c.base02;
    base03 = c.base03;
    base04 = c.base04;
    base05 = c.base05;
    base06 = c.base06;
    base07 = c.base07;
    base08 = c.base08;
    base09 = c.base09;
    base0A = c.base0A;
    base0B = c.base0B;
    base0C = c.base0C;
    base0D = c.base0D;
    base0E = c.base0E;
    base0F = c.base0F;
  };

  # Прозрачные варианты цветов для pill-подложек (#rrggbbaa понимает QML).
  alphaVars = let
    withA = a: h: "${builtins.substring 0 7 h}${a}"; # baseXX — это #rrggbb (7 символов), вешаем свой alpha
  in
    colorVars
    // {
      base01_80 = withA "80" c.base01;
      base01_cc = withA "cc" c.base01;
      base02_aa = withA "aa" c.base02;
      base03_99 = withA "99" c.base03;
    };

  widgetsDir = ./quickshell/widgets;

  shellQml = render ./quickshell/shell.qml.tpl alphaVars;

  # Виджеты лежат в modules/home/quickshell/widgets; каждый .qml.tpl — шаблон с @baseXX@.
  widgetTplNames =
    filter (f: builtins.match ".*\\.qml\\.tpl" f != null)
    (builtins.attrNames (builtins.readDir widgetsDir));

  widgetFiles =
    builtins.map
    (f: {
      name = builtins.replaceStrings [".qml.tpl"] [".qml"] f;
      text = render (widgetsDir + "/${f}") alphaVars;
    })
    widgetTplNames
    # qmldir.tpl -> qmldir (обязателен для singleton'ов Palette/NiriEvents)
    ++ [
      {
        name = "qmldir";
        text = render (widgetsDir + "/qmldir.tpl") alphaVars;
      }
    ];
in {
  # quickshell сам по себе — Qt6/QML-приложение, конфиг кладём в
  # \$XDG_CONFIG_HOME/quickshell (qs без -c ищет shell.qml именно там).
  home.packages = with pkgs; [
    quickshell # пакет из nixpkgs; бин `qs`
    jq # разбор вывода `niri msg` в JSON
    procps # free/uptime для виджета system
  ];

  # Объединяем статические файлы и динамические виджеты в один набор xdg.configFile
  xdg.configFile =
    {
      # 1. Статические файлы конфигурации
      "quickshell/shell.qml".text = shellQml;

      # Быстрый дебаг: `touch ~/.config/quickshell/.watch` — qs перезагрузит конфиг
      # без рестарта процесса (см. Quickshell.watcherEnabled).
      "quickshell/.watch".text = "";
    }
    // builtins.listToAttrs (
      # 2. Динамически генерируемые файлы виджетов
      builtins.map (f: {
        name = "quickshell/widgets/" + (builtins.replaceStrings [".qml.tpl"] [".qml"] f);
        value = {text = render (widgetsDir + "/${f}") alphaVars;};
      })
      widgetTplNames
      ++ [
        {
          name = "quickshell/widgets/qmldir";
          value = {text = render (widgetsDir + "/qmldir.tpl") alphaVars;};
        }
      ]
    );

  # Запуск панели — через spawn-at-startup в конфиге niri (см.
  # modules/home/config/niri/config.kdl). Systemd-юнит выключен, чтобы
  # не появилось двух панелей одновременно; включите WantedBy, если
  # используете qs вне сессии niri.
  systemd.user.services.quickshell = {
    Unit = {
      Description = "quickshell panel (managed by niri spawn-at-startup)";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "\${pkgs.quickshell}/bin/qs";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = []; # пусто: не автозапуск; см. spawn-at-startup в niri
  };
}
