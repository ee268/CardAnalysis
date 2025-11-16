import QtQuick 2.14
import QtQuick.Shapes 1.9
import "../basic"
import "../commonUi"

Rectangle {
    id: menuArea
    color: BasicConfig.mainAreaColor
    radius: BasicConfig.mainAreaRadius

    GASlideMenuBtn {
        anchors {
            centerIn: parent
        }

        width: parent.width / 2
        height: parent.height - 35
        menuTexts: BasicConfig.topMenuTitleTexts
        clickedEventId: "topMenu"
    }
}
