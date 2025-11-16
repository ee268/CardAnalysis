import QtQuick 2.14
import QtQuick.Controls 2.14
import "../basic"

Item {
    Rectangle {
        anchors {
            fill: parent
            topMargin: BasicConfig.topMenuAreaMargin
            leftMargin: BasicConfig.topMenuAreaMargin
            rightMargin: BasicConfig.topMenuAreaMargin
            bottomMargin: BasicConfig.topMenuAreaMargin
        }
        color: BasicConfig.mainAreaColor
        radius: BasicConfig.mainAreaRadius

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: col.height + 15
            clip: true

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

            Column {
                id: col
                spacing: 10

                TopArea {
                    width: flickable.width
                    height: 260
                }

                BottomArea {
                    width: flickable.width
                }
            }
        }
    }
}
