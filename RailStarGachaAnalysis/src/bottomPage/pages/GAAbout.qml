import QtQuick 2.14
import "../../basic"
import "../../commonUi"

Item {
    Column {
        spacing: 20
        anchors.centerIn: parent

        Image {
            width: 150
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/style/github-mark.png"
        }

        FontGrade {
            info: "https://github.com/ee268/CardAnalysis"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Qt.openUrlExternally("https://github.com/ee268/CardAnalysis")
                }
            }
        }
    }
}
