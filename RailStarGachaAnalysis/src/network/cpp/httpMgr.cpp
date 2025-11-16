#include "../include/httpMgr.h"
#include "../include/const.h"
#include <QNetworkReply>
#include <QSslSocket>
#include <QSslConfiguration>
#include <QJsonParseError>
#include <QJsonArray>
#include "../include/ProcessData.h"


httpMgr::~httpMgr()
{
	_manager->deleteLater();
}

void httpMgr::PostGachaUrl(QUrl url, QJsonObject json)
{
	qDebug() << "Post url is: " << url.toString();
	//qDebug() << QSslSocket::sslLibraryBuildVersionString();
	//
	//QNetworkRequest request(url);
	//QByteArray data = QJsonDocument(json).toJson();

	//request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
	//request.setHeader(QNetworkRequest::ContentLengthHeader, QByteArray::number(data.length()));
	//
	//auto self = shared_from_this();
	//QNetworkReply* reply = _manager->post(request, data);
	//
	//QObject::connect(reply, &QNetworkReply::finished, [self, reply]() {
	//	auto isError = reply->error();
	//	if (isError != QNetworkReply::NoError) {
	//		qDebug() << "Post request error, detail is " << isError;

	//		reply->deleteLater();
	//		return;
	//	}

	//	QString res = reply->readAll();
	//	qDebug() << "Server reply is: " << res;

	//	reply->deleteLater();
	//	return;
	//});

	QNetworkRequest request(url);

	QSslConfiguration config = QSslConfiguration::defaultConfiguration();
	config.setPeerVerifyMode(QSslSocket::VerifyNone);
	config.setProtocol(QSsl::TlsV1_2);
	request.setSslConfiguration(config);

	request.setHeader(QNetworkRequest::UserAgentHeader, QString("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"));
	request.setRawHeader("Accept", "application/json, text/plain, */*");
	request.setRawHeader("Accept-Language", "zh-CN,zh;q=0.9,en;q=0.8");
	request.setRawHeader("Host", "public-operation-hkrpg.mihoyo.com");

	auto self = shared_from_this();
	QNetworkReply* reply = _manager->get(request);

	QObject::connect(reply, &QNetworkReply::finished, [self, reply]() {
		auto isError = reply->error();
		if (isError != QNetworkReply::NoError) {
			qDebug() << "Get request error, detail is " << isError;

			reply->deleteLater();
			return;
		}

		QString res = reply->readAll();
		qDebug() << "receive reply successes, content is " << res;

		QString end_id = ProcessData::GetInstance()->StartProcess(res);

		emit self->SigPostGachaUrlFinished(end_id);
		reply->deleteLater();
		return;
	});
}

httpMgr::httpMgr()
	: _manager(new QNetworkAccessManager())
{

}
