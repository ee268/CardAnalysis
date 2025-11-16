#include "../include/ProcessData.h"
#include <QJsonParseError>
#include <QTextCodec>
#include <QDir>
#include <QFile>
#include "../include/const.h"

QString ProcessData::StartProcess(QString jsonStr)
{
	QByteArray byteArray = jsonStr.toUtf8();
	QJsonParseError err;
	_jsonDoc = _jsonDoc.fromJson(byteArray, &err);
	if (err.error != QJsonParseError::NoError) {
		qDebug() << "Parse Json occur a error that is " << err.errorString();
		return "";
	}

	_jsonObj = _jsonDoc.object();

	QString page = _jsonObj.value("data").toObject().value("page").toString();

	if (page.toInt() == 0) {
		qDebug() << "Process stopped, because page is empty";
		return "";
	}
	int listSize = _jsonObj.value("data").toObject().value("list").toArray().size();
	if (listSize == 0) {
		qDebug() << "Process stopped, because list is empty";
		return "";
	}

	qDebug() << "Get gacha page is: " << page;

	CountGachaNumber();

	return _jsonObj.value("data").toObject().value("list").toArray()[listSize - 1].toObject().value("id").toString();
}

void ProcessData::CountGachaNumber()
{
	for (auto data : _jsonObj.value("data").toObject().value("list").toArray()) {
		_jsonArray.append(data);
	}
}

void ProcessData::AnalysisGachaInfo(QString type)
{
	QJsonObject root;

	for (auto data : _jsonArray) {
		QString rank_type = data.toObject().value("rank_type").toString();
		if (rank_type == "5") {
			qDebug() << data.toObject().value("name").toString() << " " << data.toObject().value("item_type").toString();
		}
	}

	int consume = 0;
	QJsonArray infos;
	for (int i = _jsonArray.size() - 1; i >= 0; i--) {
		consume++;
		auto data = _jsonArray[i].toObject();

		if (!_saveJson.contains("uid")) {
			_saveJson["uid"] = data.value("uid").toString();
		}

		QString rank = data.value("rank_type").toString();
		if (rank == "5") {
			QJsonObject rankFiveTotalConsume;
			rankFiveTotalConsume["consume"] = consume;
			rankFiveTotalConsume["name"] = data.value("name").toString();
			rankFiveTotalConsume["item_type"] = data.value("item_type").toString();
			rankFiveTotalConsume["time"] = data.value("time").toString();
			infos.append(rankFiveTotalConsume);
			consume = 0;
		}
	}
	root["gacha_type"] = type;
	root["gacha_infos"] = infos;
	_saveJsonArray.append(root);
}

void ProcessData::SaveGachaInfoTojson()
{
	_saveJson["all_gacha"] = _saveJsonArray;
	QJsonDocument doc(_saveJson);
	QString jsonStr = doc.toJson(QJsonDocument::Compact);
	qDebug() << "json file content as follow: ";
	qDebug() << jsonStr;

	QString curPath = QDir::currentPath();
	qDebug() << "current path: " << curPath;
	curPath += saveDirName.c_str();
	QDir savesPath = curPath;
	if (!savesPath.exists() && !savesPath.mkpath(".")) {
		qDebug() << "Can't create directory:" << savesPath.absolutePath();
	}

	QString filePath = curPath + "/" + _saveJson.value("uid").toString() + ".json";
	QFile file(filePath);
	if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
		qWarning() << "Can't open file:" << "111.json" << "error:" << file.errorString();
	}


	QTextStream stream(&file);
	stream.setCodec("UTF-8");
	stream << doc.toJson(QJsonDocument::Indented);

	qDebug() << "already save json file to path: " << filePath;
	emit sigProcessFinished(_saveJson.value("uid").toString());
}

void ProcessData::ClearArray()
{
	_jsonArray = QJsonArray();
}
