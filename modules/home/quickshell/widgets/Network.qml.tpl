// Wi-Fi / Ethernet + Bluetooth (через nmcli и rfkill/bluetoothctl раз в 5с).
import QtQuick
import Quickshell.Io

Pill {
    id: root
    property string netState: "unknown"   // wifi | eth | none | disabled
    property string essid: ""
    property int signal: 0
    property bool btOn: false

    Process {
        id: probe
        running: true
        command: ["sh", "-c", String.raw`
            state="none"; essid=""; sig=0
            if [ "$(nmcli radio wifi)" = "disabled" ]; then
                state="disabled"
            else
                conn=$(nmcli -t -f STATE general status 2>/dev/null)
                # активное wifi-соединение
                wifiline=$(nmcli -t -f NAME,SIGNAL,TYPE connection show --active 2>/dev/null | grep wireless | head -1)
                eth=$(nmcli -t -f TYPE connection show --active 2>/dev/null | grep -x ethernet | head -1)
                if [ -n "$wifiline" ]; then
                    state="wifi"
                    IFS=':' read essid sig _ <<< "$wifiline"
                elif [ -n "$eth" ]; then
                    state="eth"
                fi
            fi
            bton=no
            if command -v bluetoothctl >/dev/null; then
                bluetoothctl show 2>/dev/null | grep -q 'Powered: yes' && bton=yes
            fi
            printf "%s|%s|%s|%s\n" "$state" "$essid" "$sig" "$bton"
        `]
        stdout: SplitParser { onReady: line => {
            var p = line.trim().split("|");
            root.netState = p[0] || "none";
            root.essid = p[1] || "";
            root.signal = parseInt(p[2]) || 0;
            root.btOn = p[3] === "yes";
        }}
        onExited: refreshTimer.start()
    }

    Timer { id: refreshTimer; interval: 5000; onTriggered: probe.restart() }

    function wifiIcon() {
        if (root.netState === "disabled") return "󰤮";
        if (root.netState === "eth") return "󰈀";
        if (root.netState !== "wifi") return "󰤣";
        if (root.signal >= 80) return "󰤨";
        if (root.signal >= 60) return "󰤥";
        if (root.signal >= 40) return "󰤢";
        if (root.signal >= 20) return "󰤟";
        return "󰤯";
    }

    Segment {
        icon: root.wifiIcon()
        label: root.netState === "wifi" ? root.essid : ""
        fgColor: (root.netState === "none" || root.netState === "disabled") ? Palette.red : Palette.text
    }

    Segment {
        icon: root.btOn ? "󰂱" : "󰂲"
        fgColor: root.btOn ? Palette.blue : Palette.muted
    }

    onClicked: button => {
        if (button === Qt.RightButton)
            Process.run(["sh", "-c", "nmcli radio wifi | grep -q enabled && nmcli radio wifi off || nmcli radio wifi on"]);
        else if (button === Qt.MiddleButton)
            Process.run(["sh", "-c", "rfkill toggle bluetooth"]);
        else
            Process.run(["nm-connection-editor"]);
    }
}
