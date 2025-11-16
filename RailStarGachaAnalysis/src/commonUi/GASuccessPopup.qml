import QtQuick 2.14
import QtQuick.Controls 2.14
import "../basic"

Popup {
    id: mainPopup
    modal: true
    width: 189
    height: 200

    property var checkUid: ""

    background: Rectangle {
        color: "white"
        radius: 15

        Column {
            spacing: 5
            anchors.centerIn: parent

            Image {
                id: img
                width: mainPopup.width * 0.55
                height: mainPopup.height * 0.55
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/style/poup/success.png"
                fillMode: Image.PreserveAspectCrop
            }

            GAText {
                id: text
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("获取成功！！")
                color: "#51ff64"
            }

            Rectangle {
                height: text.height + 15
                width: text.width + 15
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 15
                color: "#ffb857"

                GAText {
                    font.pixelSize: 17
                    anchors.centerIn: parent
                    text: qsTr("立即查看")
                    color: "white"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: () => {
                            console.log("checkUid is ", mainPopup.checkUid)
                            GachaInfoMgr.CheckAccountInfo(mainPopup.checkUid)
                            BasicConfig.isFromInputEnter = true
                            BasicConfig.pushAnalysisPage()
                            BasicConfig.clickedTopMenu(0, "analysisMenu")
                            mainPopup.close()
                        }
                    }
                }
            }
        }
    }
}
