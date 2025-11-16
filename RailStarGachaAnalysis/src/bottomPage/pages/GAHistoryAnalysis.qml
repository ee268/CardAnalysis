import QtQuick 2.14
import QtQuick.Controls 2.14
import "../../basic"
import "../../commonUi"

Item {

    GAText {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("点击下方uid可以查看该账号的历史分析")
        font.pixelSize: 28
    }

    Timer {
        id: timer
        interval: 200
        running: false
        repeat: false
        onTriggered: {
            popup.close()
            BasicConfig.pushAnalysisPage()
            BasicConfig.clickedTopMenu(0, "analysisMenu")
        }
    }

    GALoadingPopup {
        id: popup
        width: 189
        height: 136
        anchors.centerIn: parent

        onOpened: {
            timer.start()
        }
    }

    Flickable {
        id: flickable
        clip: true
        anchors {
            top: title.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        anchors {
            topMargin: 20
            bottomMargin: 20
            leftMargin: 20
            rightMargin: 20
        }
        contentHeight: col.implicitHeight

        ScrollBar.vertical: ScrollBar {
            //滚动条位置
            policy: ScrollBar.AlwaysOn
            anchors.right: parent.right
            anchors.rightMargin: 5
            //滚动条宽度
            width: 10
            //滚动条形状自定义
            contentItem: Rectangle {
                //是否显示滚动条依据父控件是否活动
                visible: parent.active
                implicitWidth: 10
                radius: 4
                color: "#CD9044"
            }
        }

        ListModel {
            id: historyCnt
            Component.onCompleted: {
                let list = GachaInfoMgr.GetTotalHistory()
                console.log(list)
                for (let i = 0; i < list.length; i++) {
                    let ele = {
                        "account": list[i]
                    }
                    historyCnt.append(ele)
                }
            }
        }

        Column {
            id: col
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                id: rep
                model: historyCnt
                delegate: Rectangle {
                    width: flickable.width * 0.7
                    height: text.implicitHeight
                    border {
                        width: 1
                        color: "#f9f9f9"
                    }
                    color: Qt.rgba(244, 244, 244, 0.44)
                    radius: 10

                    GAText {
                        id: text
                        anchors.centerIn: parent
                        padding: 6
                        text: account
                        color: "#5e5e5e"
                        font.pixelSize: 22
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            GachaInfoMgr.CheckAccountInfo(account)
                            popup.open()
                            BasicConfig.curMenuBtn = -1
                        }
                    }
                }
            }

            GAText {
                visible: !rep.count
                color: "#ff9a88"
                font.pixelSize: 30
                text: qsTr("暂无历史记录")
            }
        }
    }
}
