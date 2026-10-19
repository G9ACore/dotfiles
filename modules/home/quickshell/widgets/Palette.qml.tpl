// Палитра и общие метрики. quickshell поддерживает QML-синглтоны через
// pragma Singleton; файл подключается как `import "widgets" as W` -> W.Palette.
pragma Singleton

import QtQuick

QtObject {
    // ── Цвета (stylix kanagawa, подставлены из Nix) ──────────────────────
    readonly property color bg:      "@base00@"
    readonly property color surface: "@base01@"
    readonly property color surface2:"@base02@"
    readonly property color overlay: "@base03@"
    readonly property color muted:   "@base04@"
    readonly property color text:    "@base05@"
    readonly property color fg:      "@base07@"
    readonly property color red:     "@base08@"
    readonly property color orange:  "@base09@"
    readonly property color yellow:  "@base0A@"
    readonly property color green:   "@base0B@"
    readonly property color teal:    "@base0C@"
    readonly property color blue:    "@base0D@"
    readonly property color purple:  "@base0E@"
    readonly property color cyan:    "@base0F@"

    // Полупрозрачная подложка pill-виджетов — как в текущем waybar CSS.
    readonly property color pillBg: "@base01_cc@"
    readonly property color pillBgHover: "@base02_aa@"

    // ── Метрики ───────────────────────────────────────────────────────────
    readonly property int pillHeight: 34
    readonly property int pillRadius: 17
    readonly property int pillHPad: 12
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int iconSize: 16
    readonly property int fontSize: 11
}
