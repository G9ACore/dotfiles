// Кнопка swaync (как custom/tray-arrow в waybar): иконка зависит от DND/счётчика,
// клик — открыть центр, ПКМ — закрыть.
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property string iconCode: "none"   // строка из вывода swaync-client -swb

    Process {
        id: probe
        running: true
        command: ["swaync-client", "-swb"]
        stdout: SplitParser { onReady: line => {
            root.iconCode = line.trim();
        }}
        // running не сбрасываем вручную (байндиг, см. IdleInhibitor.qml).
        onExited: refreshTimer.start()
    }

    Timer { id: refreshTimer; interval: 3000; onTriggered: probe.restart() }

    function iconFor() {
        switch (root.iconCode) {
            case "notification":                 return "󱅫";
            case "dnd-notification":             return "󰂠";
            case "inhibited-notification":       return "󰂛";
            case "dnd-inhibited-notification":   return "󰂛";
            case "inhibited-none":               return "󰪑";
            case "dnd-inhibited-none":           return "󰪑";
            case "dnd-none":                     return "󰪓";
            default:                             return "󰏖";
        }
    }

    Segment {
        icon: root.iconFor()
        fgColor: root.iconCode.includes("notification") ? Palette.blue : Palette.muted
    }

    onClicked: button => {
        if (button === Qt.RightButton)
            Process.run(["swaync-client", "-d", "-sw"]);
        else
            Process.run(["swaync-client", "-t", "-sw"]);
    }
}
