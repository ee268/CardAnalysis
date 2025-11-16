#ifndef PARSEGACHAURL_H
#define PARSEGACHAURL_H

#include <QObject>
#include <QString>
#include <memory>
#include "Singleton.h"

class parseGachaUrl :
	public QObject,
	public std::enable_shared_from_this<parseGachaUrl>,
	public Singleton<parseGachaUrl>
{
	Q_OBJECT
public:
	parseGachaUrl() = default;
	~parseGachaUrl() = default;

	Q_INVOKABLE void Start(QString url);

	Q_INVOKABLE QString& GetUrl();
	
private:
	friend class Singleton<parseGachaUrl>;

	QString splitUrl(QString& url);

	QString getPage(const QString page, const QString gacha_type = "11", const QString end_id = "0");

	QString _url;

signals:
	void SigParseUrlFinished(QString type);
	void SigAllGachaParseFinished();
};

#endif