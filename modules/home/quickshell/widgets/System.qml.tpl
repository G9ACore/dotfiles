// CPU / температура — как waybar cpu+temperature (interval 10).
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property real cpuUsage: 0
    property int tempC: 0

    function pickTempIcon(t) {
        if (t >= 75) return "";
        if (t >= 55) return "";
        return "";
    }

    // Раз в 10 секунд читаем /proc/stat и hwmon.
    Process {
        id: poll
        running: true
        command: ["sh", "-c", String.raw`
            # CPU: delta по /proc/stat за интервал сна 2с между двумя снимками
            a=$(grep '^cpu ' /proc/stat)
            sleep 2
            b=$(grep '^cpu ' /proc/stat)
            calc() { echo $1 | awk '{print $2+$3+$4+$6+$7+$8}'; }
            idleA=$(echo $a | awk '{print $5}'); totalA=$(calc "$a")
            idleB=$(echo $b | awk '{print $5}'); totalB=$(calc "$b")
            usage=$(( (100*( (totalB-totalA)-(idleB-idleA) ))/(totalB-totalA) ))
            # Температура: первый доступный temp*_input в coretemp/zenpower
            t=0
            for f in /sys/class/hwmon/hwmon*/temp*_input; do
                [ -r "$f" ] || continue
                label=$(cat "$(dirname $f)/name" 2>/dev/null)
                case "$label" in coretemp|zenpower|k10temp|iwl_mwda*)
                    t=$(( $(cat "$f") / 1000 )); break;;
                esac
            done
            printf "%s %s\n" "$usage" "$t"
        `]

        stdout: SplitParser { onReady: line => {
            var parts = line.trim().split(/\s+/);
            root.cpuUsage = Number(parts[0]) || 0;
            root.tempC = Number(parts[1]) || 0;
        }}

        onExited: recheckTimer.restart()
    }

    Timer { id: recheckTimer; interval: 8000; onTriggered: Qt.callLater(() => poll.running = true) }

    Segment {
        icon: "󰻠"
        label: Math.round(root.cpuUsage) + "%"
        fgColor: root.cpuUsage >= 90 ? Palette.red : (root.cpuUsage >= 75 ? Palette.yellow : Palette.text)
    }

    Segment {
        icon: root.pickTempIcon(root.tempC)
        label: root.tempC > 0 ? root.tempC + "°" : ""
        fgColor: root.tempC >= 80 ? Palette.red : Palette.text
    }
}
