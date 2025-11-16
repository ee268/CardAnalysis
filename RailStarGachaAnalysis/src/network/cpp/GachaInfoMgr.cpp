#include "../include/GachaInfoMgr.h"
#include "../include/const.h"
#include <QFile>
#include <QDir>
#include <QJsonObject>
#include <QJsonParseError>
#include <QDateTime>

QStringList GachaInfoMgr::GetTotalHistory()
{
	QDir directory(QDir::currentPath() + saveDirName.c_str());

	if (!directory.exists()) {
		qDebug() << "Can't find directory:" << saveDirName.c_str();
		return {};
	}

	// 设置名称过滤器
	QStringList nameFilters = { "*.json" };

	// 获取文件列表（只包含文件，不包含目录）
	QStringList files = directory.entryList(nameFilters, QDir::Files | QDir::NoDotAndDotDot);

	qDebug() << "history files as follow: ";
	for (auto& s : files) {
		s = s.left(s.size() - 5);
	}

	return files;
}

Q_INVOKABLE void GachaInfoMgr::CheckAccountInfo(QString fileName)
{
	qDebug() << "fileName is " << fileName;
	QString path = QDir::currentPath() + saveDirName.c_str() + "/" + fileName + ".json";

	QFile jsonFile(path);
	if (!jsonFile.open(QIODevice::ReadOnly)) {
		qDebug() << "Can't open file " << path;
		return;
	}

	QJsonParseError jsonErr;
	QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonFile.readAll(), &jsonErr);

	if (jsonErr.error != QJsonParseError::NoError) {
		qDebug() << "Parse json file error, message is " << jsonErr.errorString();
		return;
	}

	qDebug() << "Read json file success" << jsonDoc.toJson(QJsonDocument::Compact);
	_curDoc = jsonDoc;

	CountInfo();

	CountGachas();
}

Q_INVOKABLE QString GachaInfoMgr::GetUid()
{
	QJsonObject root = _curDoc.object();
	qDebug() << "GetUid: " << root.value("uid").toString();
	return root.value("uid").toString();
}

Q_INVOKABLE int GachaInfoMgr::GetTotalConsume()
{
	return _total;
}

Q_INVOKABLE int GachaInfoMgr::GetUpCharacterConsume()
{
	return _upCharacterConsume;
}

Q_INVOKABLE int GachaInfoMgr::GetUpWeaponConsume()
{
	return _upWeaponConsume;
}

Q_INVOKABLE QString GachaInfoMgr::GetUpRatio()
{
	return _upRatio;
}

//Q_INVOKABLE QList<QStringList> GachaInfoMgr::GetGachaInfo(QString type)
//{
//	if (_gachas.find(type) == _gachas.end()) {
//		qDebug() << "Can't find gacha_type " << type;
//		return {};
//	}
//
//	return _gachas[type];
//}

Q_INVOKABLE QVariantList GachaInfoMgr::GetGachaInfo(QString type)
{
	if (_gachas.find(type) == _gachas.end()) {
		qDebug() << "Can't find gacha_type " << type;
		return QVariantList();
	}

	QVariantList result;
	const QList<QStringList>& gachaList = _gachas[type];

	for (const QStringList& row : gachaList) {
		QVariantList rowList;
		for (const QString& item : row) {
			rowList.append(item);
		}
		result.append(QVariant(rowList));
	}

	return result;
}

void GachaInfoMgr::CountInfo()
{
	_upCharacterConsume = 0;
	_upWeaponConsume = 0;
	_upRatio = "0";
	_total = 0;

	int total = 0;
	int upRole = 0, upRoleTotal = 0;
	int upWep = 0, upWepTotal = 0;
	double unUp = 0, all = 0;
	QJsonObject root = _curDoc.object();
	for (auto data : root.value("all_gacha").toArray()) {
		auto gachaInfos = data.toObject().value("gacha_infos").toArray();
		QString type = data.toObject().value("gacha_type").toString();

		for (auto info : gachaInfos) {
			int consume = info.toObject().value("consume").toInt();
			total += consume;

			if (type != "ConstGacha" && type != "NewbieGacha") {
				QString name = info.toObject().value("name").toString();
				QString testName = info.toObject().value("name").toString();

				//QByteArray code = name.toLocal8Bit();

				if (ConstGachaRole.find(name) == ConstGachaRole.end() &&
					ConstGachaWep.find(name) == ConstGachaWep.end())
				{
					QString item = info.toObject().value("item_type").toString();
					QString item2 = QString::fromLocal8Bit("角色");

					if (item == item2) {
						upRole++;
						upRoleTotal += consume;
					}
					else {
						upWep++;
						upWepTotal += consume;
					}
					all++;
				}
				else {
					unUp++;
				}
			}
		}
	}

	if (unUp && all) {
		_upRatio = QString::number((unUp / all) * 100, 'f', 2) + "%";
	}
	else {
		std::cout << "(_upRatio)Json data maybe empty" << std::endl;
	}

	if (upRoleTotal && upRole) {
		_upCharacterConsume = upRoleTotal / upRole;
	}
	else {
		std::cout << "(_upCharacterConsume)Json data maybe empty" << std::endl;
	}

	if (upWepTotal && upWep) {
		_upWeaponConsume = upWepTotal / upWep;
	}
	else {
		std::cout << "(_upWeaponConsume)Json data maybe empty" << std::endl;
	}

	_total = total;
}

void GachaInfoMgr::CountGachas()
{
	QJsonObject root = _curDoc.object();
	for (auto gacha : root.value("all_gacha").toArray()) {

		auto info = gacha.toObject().value("gacha_infos").toArray();
		QString type = gacha.toObject().value("gacha_type").toString();
		QList<QStringList> cnt;

		for (auto data : info) {
			QString name = data.toObject().value("name").toString();
			QString isUp = "false";

			if (ConstGachaRole.find(name) == ConstGachaRole.end() &&
				ConstGachaWep.find(name) == ConstGachaWep.end()) {
				isUp = "true";
			}

			QStringList single = {
				name,
				QString::number(data.toObject().value("consume").toInt()),
				data.toObject().value("time").toString(),
				isUp
			};

			cnt.push_back(single);
		}

		std::sort(cnt.begin(), cnt.end(), [](const QStringList& a, const QStringList& b){
			int timeIndex = 2;

			QDateTime dateTimeA = QDateTime::fromString(a[timeIndex], "yyyy-MM-dd hh:mm:ss");
			QDateTime dateTimeB = QDateTime::fromString(b[timeIndex], "yyyy-MM-dd hh:mm:ss");

			return dateTimeA > dateTimeB;
		});

		_gachas[type] = cnt;
	}
}
