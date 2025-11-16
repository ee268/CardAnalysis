pragma Singleton
import QtQuick 2.9

QtObject {
	property int windowWidth: 1172
	property int windowHeight: 754
	property color mainAreaColor: Qt.rgba(229, 229, 229, 0.65)
	property int mainAreaRadius: 10
	property int topMenuAreaMargin: 10
	property int topMenuTitlePixelSize: 25
	property string topMenuId: "topMenu"
	property var topMenuTitleTexts: ["历史分析", "获取分析", "关于"]
	property string customFontFamily: "qrc:/style/font/AaSiHaSiHaShouXieTi-2.ttf"
	property int curMenuBtn: 1
	property int inputAnalysisTitleSize: 40
	property int bottomStackViewSize: 1
	property bool isFromInputEnter: false

	//与topMenuTitleTexts下标对应
	property var topMenuPagesPath: [
		"qrc:/src/bottomPage/pages/GAHistoryAnalysis.qml",
		"qrc:/src/bottomPage/pages/GAInputAnalysis.qml",
		"qrc:/src/bottomPage/pages/GAAbout.qml"
	]
	property string analysisPagePath: "qrc:/src/analysisPage/AnalysisArea.qml"

	property string analysisMenuId: "analysisMenu"
	property var analysisMenuTitleTexts: [
		"up角色池",
		"up光锥池",
		"常驻池",
		"联动角色池",
		"联动武器池",
		"新手池"
	]
	property int curAnalysisMenuBtn: 0

	signal clickedTopMenu(int idx, string id)
	signal pushPage(string path)
	signal popPage()
	signal pushAnalysisPage()
	signal popAnalysisPage()
	signal updateGacha(var gacha, string type);
}
