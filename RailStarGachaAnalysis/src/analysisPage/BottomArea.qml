import QtQuick 2.14
import QtQuick.Controls 2.14
import "../basic"
import "../commonUi"

Item {
    id: rootItem
    height: mainCol.height

    Column {
        id: mainCol
        spacing: 20

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        GASlideMenuBtn {
            id: menuBtns
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.7
            height: 80
            menuTexts: BasicConfig.analysisMenuTitleTexts
            clickedEventId: "analysisMenu"
        }

        GAText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("暂无记录...")
            font.pixelSize: 30
            color: "#ff9a88"
            visible: !list.count
        }

        ListModel {
            id: list
        }

        Connections {
            target: BasicConfig
            onUpdateGacha: (gacha, type) => {
                list.clear()
                for (let i = 0; i < gacha.length; i++) {
                    if (type == "ConstGacha" || type == "NewbieGacha") {
                        gacha[i][3] = "true"
                    }

                    let ele = {
                        "name" : gacha[i][0],
                        "consume" : gacha[i][1],
                        "isUp" : gacha[i][3]
                    }
                    list.append(ele)
                }
            }
        }

        Column {
            spacing: 20
            topPadding: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: list
                delegate: Rectangle {
                    width: rootItem.width - 30
                    height: contentRow.height

                    border {
                        width: 1
                        color: "#f9f9f9"
                    }
                    color: Qt.rgba(137, 137, 137, 0.69)
                    radius: 5

                    Row {
                        id: contentRow
                        anchors {
                            left: parent.left
                            leftMargin: 10
                        }

                        spacing: 20
                        padding: 10

                        Rectangle {
                            width: rootItem.width * 0.1
                            height: width + 50
                            color: "transparent"
                            border {
                                width: 2
                                color: "#FCCE52"
                            }

                            radius: 5
                        }

                        Column {
                            spacing: 15
                            anchors.verticalCenter: parent.verticalCenter

                            GAText {
                                padding: 0
                                text: name
                                font.pixelSize: 40
                                color: "black"
                            }

                            Row {
                                spacing: 20

                                Rectangle {
                                    property int maxPgWidth: rootItem.width * 0.7
                                    id: progress
                                    width: 0
                                    height: 40
                                    radius: height

                                    gradient: Gradient {
                                        orientation: Gradient.Horizontal
                                        GradientStop {
                                            id: color1
                                            position: 0.0
                                            color: "#d4fc79"
                                        }
                                        GradientStop {
                                            id: color2
                                            position: 1.0
                                            color: "#96e6a1"
                                        }
                                    }

                                    SequentialAnimation {
                                        id: ani
                                        running: true
                                        loops: Animation.Infinite
                                        property int aniDuration: 800

                                        ParallelAnimation {
                                            PropertyAnimation {
                                                target: color1
                                                property: "color"
                                                to: "#96e6a1"
                                                duration: ani.aniDuration
                                            }
                                            PropertyAnimation {
                                                target: color2
                                                property: "color"
                                                to: "#d4fc79"
                                                duration: ani.aniDuration
                                            }
                                        }

                                        ParallelAnimation {
                                            PropertyAnimation {
                                                target: color1
                                                property: "color"
                                                to: "#d4fc79"
                                                duration: ani.aniDuration
                                            }
                                            PropertyAnimation {
                                                target: color2
                                                property: "color"
                                                to: "#96e6a1"
                                                duration: ani.aniDuration
                                            }
                                        }
                                    }

                                    Behavior on width {
                                        NumberAnimation {
                                            duration: 500
                                        }
                                    }

                                    Component.onCompleted: {
                                        //使用Timer延迟设置宽度，确保Behavior生效
                                        timer.start()
                                    }

                                    Timer {
                                        id: timer
                                        interval: 10
                                        onTriggered: {
                                            progress.width = progress.maxPgWidth * (parseInt(consume, 10) / 100)
                                        }
                                    }
                                }

                                GAText {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: consume
                                    font.pixelSize: 35
                                    color: "black"
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: progress.height
                                    height: width
                                    radius: height
                                    color: "transparent"
                                    border {
                                        width: 3
                                        color: "red"
                                    }

                                    GAText {
                                        anchors.centerIn: parent
                                        text: qsTr("歪")
                                        color: "red"
                                        font.pixelSize: parent.width - 13
                                    }

                                    visible: {
                                        if (isUp === "false") {
                                            return true
                                        }
                                        return false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
