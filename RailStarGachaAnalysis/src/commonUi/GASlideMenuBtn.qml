import QtQuick 2.14
import QtQuick.Shapes 1.9
import "../basic"
import "../commonUi"

Rectangle {
	id: menuBorder
	radius: height

	property var menuTexts: []
	property string clickedEventId: ""

	Connections {
		target: BasicConfig

		onClickedTopMenu: (idx, id) => {
			switch(id) {
				case "topMenu":
					if (BasicConfig.curMenuBtn === idx) {
						return
					}


					BasicConfig.curMenuBtn = idx

					for (let i = 0; i < BasicConfig.topMenuTitleTexts.length; i++) {
						if (i === idx) {
						  BasicConfig.pushPage(BasicConfig.topMenuPagesPath[i])
						}
					}
					break
				case "analysisMenu":
					if (BasicConfig.curMenuBtn === idx) {
						return
					}

					BasicConfig.curMenuBtn = idx

					let type = ""

					switch(BasicConfig.curMenuBtn) {
						case 0:
							type = "UpGacha"
							break
						case 1:
							type = "UpWeaponGacha"
							break
						case 2:
							type = "ConstGacha"
							break
						case 3:
							type = "LinkageGacha"
							break
						case 4:
							type = "LinkageWepGacha"
							break
						case 5:
							type = "NewbieGacha"
							break
						default:
							break
					}

					let res = GachaInfoMgr.GetGachaInfo(type)
					BasicConfig.updateGacha(res, type)

					break
				default:
					break
			}
		}
	}

	gradient: Gradient{
		orientation: Gradient.Horizontal

		GradientStop { position:0.25; color:"#f3c232" }
		GradientStop { position:0.5; color:"#f6bb36" }
		GradientStop { position:0.75; color:"#fab33b" }
		GradientStop { position:1.0; color:"#fdac3f" }
	}

	Rectangle {
		id: menuInner
		anchors.centerIn: parent
		width: parent.width - 10
		height: parent.height - 10
		// color: "pink"
		color: Qt.rgba(245, 245, 245, 0.52)
		radius: height

		QtObject {
			id: props
			property int btnX:
				BasicConfig.curMenuBtn * menuInner.width / menuBorder.menuTexts.length
		}

		//按钮
		Rectangle {
			id: menuButton
			y: 0
			x: {
				if (BasicConfig.curMenuBtn < 0) {
					return 0
				}
				return props.btnX
			}
			width: menuInner.width / repTitle.count
			height: menuInner.height
			radius: height
			// z: 100

			gradient: Gradient {
				GradientStop { position:0.33; color:"#0ebeff" }
				GradientStop { position:0.66; color:"#18b9fc" }
				GradientStop { position:1.0; color:"#22b4f9" }
			}

			Behavior on x {
				NumberAnimation {
					duration: 200
				}
			}
		}

		//标题文字
		Row {
			anchors.centerIn: parent

			Repeater {
				id: repTitle
				model: menuBorder.menuTexts
				delegate: Item {
					id: textItem
					height: menuInner.height
					width: menuInner.width / repTitle.count

					GAText {
						anchors.centerIn: parent
						text: modelData
						color: "black"
						font.pixelSize: BasicConfig.topMenuTitlePixelSize
					}

					MouseArea {
						anchors.fill: parent
						cursorShape: Qt.PointingHandCursor

						onClicked: {
							BasicConfig.clickedTopMenu(index, menuBorder.clickedEventId)
						}
					}
				}
			}
		}
	}
}
