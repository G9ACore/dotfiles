// quickshell: единый фоновый процесс `niri msg -j event stream`,
// все виджеты (workspaces / focused window / audio) читают из него.
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Templates as T

QtObject {
    id: root

    // ── Состояние ─────────────────────────────────────────────────────────
    property var workspaces: []           // массив объектов workspace из события
    property int activeWsId: 0
    property string focusedTitle: ""
    property string focusedAppId: ""
    property bool niriUp: false

    // Непрерывный JSON-стрим событий niri.
    Process {
        id: eventStream
        command: ["niri", "msg", "-j", "event", "stream"]
        running: true

        stdout: SplitParser {
            splitKeep: ["\n"]
            // Каждое событие — одна JSON-строка.
            onReady: line => {
                try {
                    var ev = JSON.parse(line);
                    root.onEvent(ev);
                } catch (e) { /* игнорируем неполные чанки */ }
            }
        }

        // Стрим живёт, пока работает niri; при падении qs перезапустится сам
        // через spawn-at-startup. Перезапуск изнутри не делаем: running —
        // байндиг-свойство Process, ручное присваивание игнорируется.
    }

    function onEvent(ev) {
        root.niriUp = true;

        if (ev["Workspace"]) {
            var w = ev["Workspace"];
            root.workspaces = w["workspaces"];
            for (var i = 0; i < w["workspaces"].length; i++) {
                if (w["workspaces"][i]["is-focused"]) {
                    root.activeWsId = w["workspaces"][i]["id"];
                }
            }
        } else if (ev["FocusedWindow"]) {
            var f = ev["FocusedWindow"];
            if (f["window"]) {
                root.focusedTitle = f["window"]["title"] ?? "";
                root.focusedAppId = f["window"]["app-id"] ?? "";
            } else {
                root.focusedTitle = "";
                root.focusedAppId = "";
            }
        }
    }

    // Действия через CLI (быстрые, без ожидания ответа).
    function focusWorkspace(id) {
        Process.run(["niri", "action", "focus-workspace", String(id)]);
    }
}
