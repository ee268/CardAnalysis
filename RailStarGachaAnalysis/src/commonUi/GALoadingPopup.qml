import QtQuick 2.14
import QtQuick.Controls 2.14

Popup {
    id: popup
    modal: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        color: "white"
        radius: 15

        Column {
            spacing: 5
            anchors.centerIn: parent

            AnimatedImage {
                width: popup.width * 0.7
                height: popup.height * 0.7
                source: "qrc:/style/poup/loading.gif"
                fillMode: Image.PreserveAspectCrop
            }

            GAText {
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("正在读取...")
                color: "black"
            }
        }
    }
}
