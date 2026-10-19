// Воркспейсы niri: pill с точками-иконками; клик — focus-workspace.
import QtQuick

Pill {
    id: root

    Repeater {
        model: NiriEvents.workspaces

        delegate: Text {
            required property var modelData
            text: {
                if (modelData["is-focused"]) return "󰮯";       // активный
                if (modelData["is-urgent"]) return "󰧵";         // urgent
                if (modelData["floating-column-count"] > 0 ||
                    (modelData["windows"] && modelData["windows"].length > 0))
                    return "󰊠";                                  // занят, но не активен
                return "";                                      // пустой
            }
            font.family: Palette.fontFamily
            font.pixelSize: Palette.iconSize
            color: modelData["is-focused"] ? Palette.blue : Palette.muted
            MouseArea {
                anchors.fill: parent
                onClicked: NiriEvents.focusWorkspace(modelData["id"])
            }
        }
    }
}
