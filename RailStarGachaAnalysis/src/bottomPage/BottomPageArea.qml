import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.15
import "../basic"
import "./pages"

Rectangle {
    color: BasicConfig.mainAreaColor
    radius: BasicConfig.mainAreaRadius

    // GAInputAnalysis {
    //     anchors {
    //         top: parent.top
    //     }

    //     width: parent.width
    //     height: parent.height * 0.7
    // }

    Connections {
        target: BasicConfig

        onPushPage: (path) => {
            BasicConfig.bottomStackViewSize++
            view.push(path)
        }

        onPopPage: () => {
            BasicConfig.bottomStackViewSize--
            view.pop()
        }
    }

    StackView {
        id: view
        anchors.fill: parent
        clip: true

        initialItem: BasicConfig.topMenuPagesPath[1]
    }
}
