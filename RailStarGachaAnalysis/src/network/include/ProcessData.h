#ifndef PROCESSDATA_H
#define PROCESSDATA_H
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include "Singleton.h"
#include <QObject>

class ProcessData: 
	public QObject,
	public std::enable_shared_from_this<ProcessData>,
	public Singleton<ProcessData>
{
	Q_OBJECT
	friend class Singleton<ProcessData>;
public:
	~ProcessData() = default;

	QString StartProcess(QString jsonStr);

	void ClearArray();

private:
	ProcessData() = default;

	void CountGachaNumber();

	QJsonDocument _jsonDoc;
	QJsonObject _jsonObj;
	QJsonArray _jsonArray;
	QJsonObject _saveJson;
	QJsonArray _saveJsonArray;

signals:
	void sigProcessFinished(QString uid);

public slots:
	void AnalysisGachaInfo(QString type);
	void SaveGachaInfoTojson();
};

#endif