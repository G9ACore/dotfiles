// Батарея: sysfs (без лишних зависимостей), иконки/цвета по порогу 30/15.
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property int capacity: -1     // -1 = нет батареи (стационарная машина)
    property bool charging: false

    Process {
        id: probe
        running: true
        command: ["sh", "-c", String.raw`
            for b in /sys/class/power_supply/BAT*; do
                [ -d "$b" ] || continue
                cap=$(cat "$b/capacity" 2>/dev/null)
                st=$(cat "$b/status" 2>/dev/null)
                printf "%s|%s\n" "$cap" "$st"
                exit 0
            done
            printf "none|none\n"
        `]
        stdout: SplitParser { onReady: line => {
            var p = line.trim().split("|");
            if (p[0] === "none") { root.capacity = -1; return; }
            root.capacity = parseInt(p[0]);
            root.charging = p[1] === "Charging";
        }}
        onExited: refreshTimer.start()
    }

    Timer { id: refreshTimer; interval: 60000; onTriggered: probe.restart() }

    function iconFor() {
        if (root.charging) return "󱐌";
        if (root.capacity < 0) return "";
        if (root.capacity >= 90) return "󰁹";
        if (root.capacity >= 80) return "󰂂";
        if (root.capacity >= 70) return "󰂁";
        if (root.capacity >= 60) return "󰂀";
        if (root.capacity >= 50) return "󰁿";
        if (root.capacity >= 40) return "󰁾";
        if (root.capacity >= 30) return "󰁽";
        if (root.capacity >= 20) return "󰁼";
        if (root.capacity >= 10) return "󰁻";
        return "󰂎";
    }

    function colorFor() {
        if (root.charging) return Palette.green;
        if (root.capacity <= 15) return Palette.red;
        if (root.capacity <= 30) return Palette.yellow;
        return Palette.text;
    }

    visible: root.capacity >= 0

    Segment {
        icon: root.iconFor()
        label: root.capacity >= 0 ? root.capacity + "%" : ""
        fgColor: root.colorFor()
    }
}
