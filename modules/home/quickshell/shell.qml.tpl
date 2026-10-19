// shell.qml — корневой файл quickshell. Сгенерирован из shell.qml.tpl модулем
// modules/home/quickshell.nix (цвета stylix уже подставлены вместо плейсхолдеров).
//
// Архитектура: один слой-панель сверху (exclusive zone), внутри Row с группами
// виджетов. Виджеты — отдельные компоненты в ./widgets/.

import QtQuick
import Quickshell
import Quickshell.Io
import "widgets" as W

ShellRoot {
    // Глобальные палитра/метрики и стрим событий niri — синглтоны из widgets/qmldir.
    W.Palette {}
    // NiriEvents — синглтон (см. widgets/qmldir), создаётся автоматически, не инстанцируем.

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            exclusiveZone: 58           // 8 (margin) + 42 (панель) + 8 — niri отодвинет окна
            margins.top: 8              // "плавающая" панель как в waybar-конфиге
            margins.left: 8
            margins.right: 8

            color: "transparent"

            implicitHeight: 42

            // ── LEFT ────────────────────────────────────────────────
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                W.Distro {}
                W.System {}
                W.IdleInhibitor {}
            }

            // ── CENTER: focused window + workspaces ─────────────────
            Row {
                anchors.centerIn: parent
                spacing: 8

                W.Focused {}
                W.Workspaces {}
            }

            // ── RIGHT ───────────────────────────────────────────────
            Row {
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                W.Audio {}
                W.Network {}
                W.Battery {}
                W.Clock {}
                W.TrayNotif {}
            }
        }
    }
}
