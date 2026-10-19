// Иконка-сегмент (Nerd Font) с опциональным текстом — базовый кирпичик виджетов.
import QtQuick

Row {
    id: root
    property string icon: ""
    property string label: ""
    property color fgColor: Palette.text
    spacing: 4

    Text {
        visible: root.icon !== ""
        text: root.icon
        font.family: Palette.fontFamily
        font.pixelSize: Palette.iconSize
        color: root.fgColor
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        visible: root.label !== ""
        text: root.label
        font.family: Palette.fontFamily
        font.pixelSize: Palette.fontSize
        color: root.fgColor
        anchors.verticalCenter: parent.verticalCenter
    }
}
