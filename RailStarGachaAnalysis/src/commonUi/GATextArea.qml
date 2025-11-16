import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

Item {

    function getText() {
        return textArea.text
    }

    ScrollView {
        anchors.fill: parent

        TextArea {
            id: textArea
            placeholderText: qsTr("粘贴或输入链接......")

            background: Rectangle {
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    GradientStop { position:0.25; color:"#f3c232" }
                    GradientStop { position:0.5; color:"#f6bb36" }
                    GradientStop { position:0.75; color:"#fab33b" }
                    GradientStop { position:1.0; color:"#fdac3f" }
                }

                radius: 10

                Rectangle {
                    width: parent.width - 10
                    height: parent.height - 10
                    radius: parent.radius + 1
                    anchors.centerIn: parent
                    color: "white"
                }
            }

            padding: 15
            wrapMode: Text.Wrap
            font {
                pixelSize: 20
                family: "微软雅黑"
            }
            selectByMouse: true
            focusReason: Qt.MouseFocusReason
        }
    }
}
