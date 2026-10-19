// Общий «pill»-контейнер для виджетов панели (скруглённая подложка + Row).
import QtQuick
import QtQuick.Controls

RoundRectangle {
    id: root

    // Дочерние виджеты кладём НЕ в Row (Row — layout, его children управляются
    // им самим), а в отдельный Item-контейнер contentItem. Иначе Positioners
    // ломаются на динамических children (Repeater) — известное QML-ограничение.
    default property alias content: contentItem.data
    property alias spacing: row.spacing
    property string tooltipText: ""
    property int maxContentWidth: -1   // -1 = без ограничения

    height: Palette.pillHeight
    radius: Palette.pillRadius
    // width считается вручную: implicitWidth у RoundRectangle не растёт от children.
    // 100000 вместо Infinity — на случай, если какой-то layout вернёт NaN/Infinity.
    width: Math.min(
      row.implicitWidth + Palette.pillHPad * 2,
      maxContentWidth >= 0 ? maxContentWidth : 100000
    )
    color: mouse.containsMouse ? Palette.pillBgHover : Palette.pillBg

    Item {
        id: contentItem
        anchors.centerIn: parent
        width: row.width
        height: row.height

        Row {
            id: row
            spacing: 8
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons
        onClicked: if (root.clicked) root.clicked(mouse.button)
    }

    // Сигнал клика с кнопкой — наружу.
    signal clicked(int mouseButton)

    ToolTip {
        visible: mouse.containsMouse && root.tooltipText !== ""
        text: root.tooltipText
        delay: 300
    }
}
