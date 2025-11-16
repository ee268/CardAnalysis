import QtQuick 2.9
import QtQuick.Controls 2.14
import "../basic"
import "../commonUi"

Button {
    id: control
    text: qsTr("获取分析")
    property color textColor: "black"
    property int textSize: 25

    // FontLoader {
    //     id: customFont
    //     source: BasicConfig.customFontFamily
    // }

    // font: customFont.name

    contentItem: GAText {
        text: control.text
        font.pixelSize: control.textSize
        color: control.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: controlBg
        implicitWidth: 100
        implicitHeight: 40
        border {
            width: 1
            color: "orange"
        }

        opacity: 1

        gradient: Gradient {
            GradientStop { position: 0.33; color: "#ffaf24"; }
            GradientStop { position: 0.66; color: "#ffbd36"; }
            GradientStop { position: 1.0; color: "#ffcb48"; }
        }

        radius: 5

        Behavior on opacity {
            NumberAnimation {
                duration: 50
            }
        }
    }

    onPressed: () => {
        controlBg.opacity = 0.6
    }

    onReleased: () => {
        controlBg.opacity = 1
    }
}
