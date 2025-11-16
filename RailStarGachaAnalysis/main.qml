import QtQuick 2.14
import QtQuick.Controls 2.14
import "./src/commonUi"
import "./src/basic"
import "./src/topPage"
import "./src/bottomPage"

GAWindow {
    id: window
    width: BasicConfig.windowWidth
    height: BasicConfig.windowHeight

    minimumWidth: BasicConfig.windowWidth
    minimumHeight: BasicConfig.windowHeight

    Item {
        id: mainPage

        GAMenuArea {
            id: topArea
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right

                topMargin: BasicConfig.topMenuAreaMargin
                leftMargin: BasicConfig.topMenuAreaMargin
                rightMargin: BasicConfig.topMenuAreaMargin
                bottomMargin: BasicConfig.topMenuAreaMargin
            }

            height: 100
        }

        BottomPageArea {
            id: bottomArea
            anchors {
                top: topArea.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom

                topMargin: BasicConfig.topMenuAreaMargin + 10
                leftMargin: BasicConfig.topMenuAreaMargin
                rightMargin: BasicConfig.topMenuAreaMargin
                bottomMargin: BasicConfig.topMenuAreaMargin
            }
        }

    }

    Connections {
        target: BasicConfig
        onPushAnalysisPage: () => {
            mainView.push(BasicConfig.analysisPagePath)
        }

        onPopAnalysisPage: () => {
            mainView.pop()
        }
    }

    StackView {
        id: mainView
        anchors.fill: parent
        initialItem: mainPage
        // initialItem: BasicConfig.analysisPagePath
    }
}
