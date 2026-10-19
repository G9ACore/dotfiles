// Заголовок сфокусированного окна (берётся из NiriEvents) + иконка по app-id.
import QtQuick

Pill {
    id: root

    // Длинные заголовки: ограничиваем ширину pill'а, а текст режем по словам
    // прямо в QML (ElideRight внутри Row не работает — у Row нет clip).
    maxContentWidth: 460

    property int maxTitleChars: 52

    function elide(t) {
        if (!t) return "";
        return t.length > root.maxTitleChars ? t.substring(0, root.maxTitleChars) + "…" : t;
    }

    property var iconMap: ({
        "foot": "󰆍",
        "zen-beta": "",
        "firefox": "",
        "discord": "",
        "obsidian": "󰹕",
        "yazi": "",
        "imv": "󰄄",
        "vlc": "󰕼",
        "mpv": "󰕼",
        "blueman-manager": "",
        "pavucontrol": "󱕂",
        "org.kde.kdeconnect.app": "󰦉",
        "org.qbittorrent.qBittorrent": "󰘿",
        "neovim": "",
        "code": "󰨞"
    })

    function iconFor(appId) {
        if (!appId) return "";
        // app-id может быть "...app.desktop" или с дефисами — нормализуем
        var base = appId.replace(/\.desktop$/, "").toLowerCase();
        for (var k in root.iconMap) {
            if (base.includes(k.toLowerCase())) return root.iconMap[k];
        }
        return "󰙯"; // generic window
    }

    Segment {
        icon: root.iconFor(NiriEvents.focusedAppId)
        label: root.elide(NiriEvents.focusedTitle)
        fgColor: Palette.text
    }

    visible: NiriEvents.focusedTitle !== ""
}
