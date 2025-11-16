#ifndef GACHAINFOMGR_H
#define GACHAINFOMGR_H
#include "Singleton.h"
#include <QObject>
#include <QJsonDocument>
#include <vector>
#include <map>

class GachaInfoMgr: 
	public QObject,
	public std::enable_shared_from_this<GachaInfoMgr>,
	public Singleton<GachaInfoMgr>
{
	Q_OBJECT
public:
	~GachaInfoMgr() = default;

	Q_INVOKABLE QStringList GetTotalHistory();

	Q_INVOKABLE void CheckAccountInfo(QString fileName);

	Q_INVOKABLE QString GetUid();

	Q_INVOKABLE int GetTotalConsume();

	Q_INVOKABLE int GetUpCharacterConsume();

	Q_INVOKABLE int GetUpWeaponConsume();

	Q_INVOKABLE QString GetUpRatio();

	Q_INVOKABLE QVariantList GetGachaInfo(QString type);

private:
	friend class Singleton<GachaInfoMgr>;
	GachaInfoMgr() = default;

	void CountInfo();

	void CountGachas();

	QJsonDocument _curDoc;
	int _upCharacterConsume = 0;
	int _upWeaponConsume = 0;
	QString _upRatio = "0";
	int _total = 0;
	QMap<QString, QList<QStringList>> _gachas;
};

#endif