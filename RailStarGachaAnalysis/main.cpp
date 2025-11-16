#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include "./src/network/include/parseGachaUrl.h"
#include "./src/network/include/GachaInfoMgr.h"
#include "./src/network/include/ProcessData.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Parser", parseGachaUrl::GetInstance().get());
    engine.rootContext()->setContextProperty("GachaInfoMgr", GachaInfoMgr::GetInstance().get());
    engine.rootContext()->setContextProperty("ProcessData", ProcessData::GetInstance().get());

	//注册全局单例控件
	qmlRegisterSingletonType(QUrl("qrc:/src/basic/BasicConfig.qml"), "BasicConfig", 1, 0, "BasicConfig");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //设置程序图标
    app.setWindowIcon(QIcon(":/style/appIcon.ico"));

    return app.exec();
}
