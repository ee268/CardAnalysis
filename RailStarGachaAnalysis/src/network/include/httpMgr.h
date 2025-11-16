#ifndef HTTPMGR_H
#define HTTPMGR_H

#include <QString>
#include <QObject>
#include <memory>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QJsonObject>
#include <QJsonDocument>
#include "Singleton.h"

class httpMgr: 
	public QObject,
	public Singleton<httpMgr>,
	public std::enable_shared_from_this<httpMgr>
{
	Q_OBJECT
	friend class Singleton<httpMgr>;
public:
	~httpMgr();

	void PostGachaUrl(QUrl url, QJsonObject json);

private:
	httpMgr();
	QNetworkAccessManager* _manager;

signals:
	void SigPostGachaUrlFinished(QString end_id);
};

#endif // HTTPMGR_H