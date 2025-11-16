import QtQuick 2.14
import QtQuick.Controls 2.14
import "../basic"
import "../commonUi"

Item {
    Item {
        anchors {
            fill: parent
            topMargin: 15
            bottomMargin: 15
            leftMargin: 15
            rightMargin: 15
        }

        GAButton {
            id: backBtn
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: 100

            text: "返回"
            textColor: "white"
            textSize: 30

            onClicked: {
                if (BasicConfig.isFromInputEnter) {
                    BasicConfig.curMenuBtn = 1
                    BasicConfig.isFromInputEnter = false
                }
                else {
                    BasicConfig.curMenuBtn = 0
                }

                BasicConfig.popAnalysisPage()
            }
        }

        Rectangle {
            anchors {
                left: backBtn.right
                leftMargin: 20
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            radius: 5
            border {
                width: 1
                color: "#f9f9f9"
            }
            color: Qt.rgba(137, 137, 137, 0.69)

            Column {
                padding: 18
                anchors.horizontalCenter: parent.horizontalCenter

                GAText {
                    text: GachaInfoMgr.GetUid()
                    font.pixelSize: 33
                    color: "black"
                }

                GAText {
                    text: qsTr("大欧皇")
                    font.pixelSize: 43
                    color: "#FCCE52"
                }

                Row {
                    spacing: 25

                    ListModel {
                        id: listModel

                        ListElement {
                            name: "不歪概率"
                            nameColor: "#FF9F43"
                        }

                        ListElement {
                            name: "总抽数"
                            nameColor: "#FF9F43"
                        }

                        ListElement {
                            name: "up角色平均花费"
                            nameColor: "#FF9F43"
                        }

                        ListElement {
                            name: "up光锥平均花费"
                            nameColor: "#FF9F43"
                        }
                    }

                    Repeater {
                        model: listModel
                        delegate: Column {
                            spacing: 15

                            GAText {
                                text: name
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 33
                                color: nameColor
                            }

                            GAText {
                                text: {
                                    switch(index) {
                                    case 0: //不歪概率
                                        return GachaInfoMgr.GetUpRatio()
                                    case 1: //总抽数
                                        return GachaInfoMgr.GetTotalConsume()
                                    case 2: //up角色平均花费
                                        return GachaInfoMgr.GetUpCharacterConsume()
                                    case 3: //up光锥平均花费
                                        return GachaInfoMgr.GetUpWeaponConsume()
                                    }
                                }

                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 50
                                color: nameColor
                            }
                        }
                    }
                }
            }
        }
    }
}
