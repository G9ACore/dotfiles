// Часы: локальное время, формат как в waybar ({:%H.%M}); ПКМ — дата.
import QtQuick

Pill {
    id: root
    property bool showDate: false

    Text {
        anchors.verticalCenter: parent.verticalCenter
        // root.tick — перерисовка раз в секунду по таймеру ниже.
        text: {
            var d = new Date();
            root.tick;
            if (root.showDate) return Qt.formatDateTime(d, "dd MMM yyyy");
            return Qt.formatDateTime(d, "HH:mm");
        }
        font.family: Palette.fontFamily
        font.pixelSize: Palette.fontSize
        color: Palette.text
    }

    // Перерисовка раз в минуту + переключение по клику.
    Timer {
        interval: 1000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: root.tick += 1
    }
    property int tick: 0

    onClicked: button => {
        if (button === Qt.RightButton) root.showDate = !root.showDate;
    }
}
