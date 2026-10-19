//  NixOS — клик открывает wlogout (как в waybar custom/distro).
import QtQuick
import Quickshell.Io

Pill {
    id: root
    tooltipText: "Menu"

    Segment {
        icon: ""
        fgColor: Palette.blue
    }

    onClicked: button => {
        Process.run(["sh", "-c", "pkill wlogout || wlogout"]);
    }
}
