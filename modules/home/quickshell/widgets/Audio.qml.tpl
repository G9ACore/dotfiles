// Громкость (pulse via wpctl) + микрофон; клик → pavucontrol, ПКМ → mute.
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property int vol: 0
    property bool muted: false
    property bool micMuted: false

    // Разовое чтение состояния default sink/source.
    Process {
        id: probe
        running: true
        command: ["sh", "-c", String.raw`
            s=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
            m=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
            printf "%s|%s\n" "$s" "$m"
        `]
        stdout: SplitParser { onReady: line => {
            var sinkPart = line.split("|")[0];
            var srcPart = line.split("|")[1] || "";
            var vm = sinkPart.match(/Volume:\s*([0-9.]+)/);
            root.vol = vm ? Math.round(parseFloat(vm[1]) * 100) : 0;
            root.muted = sinkPart.includes("[MUTED]");
            root.micMuted = srcPart.includes("[MUTED]");
        }}
        onExited: refreshTimer.start()
    }

    Timer { id: refreshTimer; interval: 2000; onTriggered: probe.restart() }

    function iconFor() {
        if (root.muted) return "󰝟";
        if (root.vol === 0) return "󰕾";
        if (root.vol < 34) return "";
        if (root.vol < 67) return "";
        return "";
    }

    Segment {
        icon: root.iconFor()
        label: root.vol + "%"
        fgColor: root.muted ? Palette.red : Palette.text
    }

    Segment {
        icon: root.micMuted ? "" : ""
        fgColor: root.micMuted ? Palette.red : Palette.muted
    }

    onClicked: button => {
        if (button === Qt.RightButton)
            Process.run(["sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"]);
        else
            Process.run(["pavucontrol"]);
    }
}
