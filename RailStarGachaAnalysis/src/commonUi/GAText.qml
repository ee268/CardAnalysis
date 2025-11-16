import QtQuick 2.14
import "../basic"

Text {
    FontLoader {
        id: aLibabaPuHuiTi
        source: BasicConfig.customFontFamily
    }

    color: "black"

    font {
        family: aLibabaPuHuiTi.name
    }
}
