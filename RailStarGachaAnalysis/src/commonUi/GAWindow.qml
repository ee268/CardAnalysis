import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    title: qsTr("星铁抽卡分析")
    color: "#626262"

    //窗口背景
    Item {
        id: bg
        anchors.fill: parent

        Image {
            id: bgImg
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            opacity: 0.3
            source: "qrc:/style/bg/3.7versionCover.png"
        }
    }

    Component.onCompleted: {
        // 初次启动时，窗口居中屏幕
        window.x = (Screen.width - window.width) / 2
        window.y = (Screen.height - window.height) / 2
    }
}
