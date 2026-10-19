// quickshell: единый фоновый процесс `niri msg -j event stream`,
// все виджеты (workspaces / focused window / audio) читают из него.
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// ВАЖНО: у QtObject нет default property — нельзя класть Process внутрь
// фигурных скобок. Поэтому состояние храним в Item, а процесс — в его children.
Item {
    id: root
    visible: false
    width: 0
    height: 0

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
            // Каждое событие — одна JSON-строка (стрим построчный).
            onReady: line => {
                try {
                    var ev = JSON.parse(line);
                    root.onEvent(ev);
                } catch (e) { /* игнорируем неполные чанки */ }
            }
        }

        // Если стример упал (niri перезапустился и т.п.) — переподключаемся.
        // Перезапуск строго через restart(): running забайнжено на true,
        // ручное присваивание игнорируется/ломает байндиг.
        onExited: restartTimer.start()
    }

    Timer { id: restartTimer; interval: 2000; onTriggered: eventStream.restart() }

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
        } else if (ev["WindowFocus"]) {
            // niri event stream: "WindowFocus" = сфокусированное окно
            // (null, если фокуса нет). Ключ "FocusedWindow" не существует.
            var f = ev["WindowFocus"];
            if (f) {
                root.focusedTitle = f["title"] ?? "";
                root.focusedAppId = f["app-id"] ?? "";
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
