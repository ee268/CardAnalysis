import QtQuick 2.9
import "../../basic"
import "../../commonUi"

Item {

    Connections {
        target: ProcessData
        onSigProcessFinished: (uid) => {
            loadingPopup.close()
            successPopup.checkUid = uid
            successPopup.open()
        }
    }

    GALoadingPopup {
        id: loadingPopup
        width: 189
        height: 136
        anchors.centerIn: parent
    }

    GASuccessPopup {
        id: successPopup
        width: 210
        height: 240
        anchors.centerIn: parent
    }

    GAText {
        id: title
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        font.pixelSize: BasicConfig.inputAnalysisTitleSize
        text: qsTr("请在下方输入链接")
    }

    GATextArea {
        id: textArea

        anchors {
            top: title.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        width: parent.width * 0.65
        height: parent.height * 0.5
    }

    GAButton {
        anchors {
            top: textArea.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        width: textArea.width * 0.6
        height: 50

        onClicked: {
            loadingPopup.open()
            Parser.Start(textArea.getText())
        }
    }
}
