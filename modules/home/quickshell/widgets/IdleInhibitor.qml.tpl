// Индикатор активной блокировки сна (как idle_inhibitor в waybar).
// quickshell не умеет сам inhibit — читаем список через systemd + loginctl.
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property bool inhibited: false

    Process {
        id: probe
        running: true
        command: ["sh", "-c", String.raw`
            # кто держит inhibit: grep по Inhibit-свойствам сессий
            for s in /run/systemd/users/*/inhibit/*; do
                [ -e "$s" ] && echo yes && exit 0
            done
            echo no
        `]
        stdout: SplitParser { onReady: line => {
            root.inhibited = line.trim() === "yes";
        }}
        // Process завершается сам (разовая команда); перезапуск — по таймеру.
        // running НЕ сбрасываем вручную: свойство байндится к true, ручное
        // присваивание игнорируется/ломает байндиг.
        onExited: refreshTimer.restart()
    }

    Timer { id: refreshTimer; interval: 10000; onTriggered: Qt.callLater(() => probe.running = true) }

    Segment {
        icon: root.inhibited ? "󰛨" : "󰛩"
        fgColor: root.inhibited ? Palette.green : Palette.muted
    }
}
