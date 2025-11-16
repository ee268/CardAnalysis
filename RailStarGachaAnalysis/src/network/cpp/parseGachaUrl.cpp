#include "../include/parseGachaUrl.h"
#include "../include/const.h"
#include "../include/httpMgr.h"
#include <thread>
#include <chrono>
#include <QEventLoop>
#include "../include/ProcessData.h"
#include <random>

Q_INVOKABLE void parseGachaUrl::Start(QString url)
{
	//std::string ori_str = url.toStdString();
	QString full_url = mihoyoHost.c_str();
	full_url += get_url.c_str();
	full_url += splitUrl(url);
	if (full_url.length() == get_url.length()) {
		qDebug() << "Parse Error, Function \"Start\" stopped.";
		return;
	}

	QJsonObject jsonObj;
	//jsonObj["url"] = ori_str.c_str();

	QObject::connect(
		this,
		&parseGachaUrl::SigParseUrlFinished,
		ProcessData::GetInstance().get(),
		&ProcessData::AnalysisGachaInfo
	);

	QObject::connect(
		this,
		&parseGachaUrl::SigAllGachaParseFinished,
		ProcessData::GetInstance().get(),
		&ProcessData::SaveGachaInfoTojson
	);

	//std::string serverUrl = "http://" + serverAdd + ":" + serverPort + "/post_gacha_url";

	for (auto& type : Gacha_Type) {
		ProcessData::GetInstance()->ClearArray();
		QString end_id = "0";
		for (int page = 1; ; page++) {
			QString gacha = QString(type.second.c_str());
			_url = full_url + getPage(QString::number(page), gacha, end_id);

			QEventLoop loop;

			QObject::connect(httpMgr::GetInstance().get(), &httpMgr::SigPostGachaUrlFinished, &loop, [&loop, &end_id](const QString id) {
				end_id = id;
				loop.quit();
				});

			httpMgr::GetInstance()->PostGachaUrl(QUrl(_url), jsonObj);

			loop.exec();

			if (end_id.isEmpty()) {
				qDebug() << "Parse Gacha Info Stopped";
				break;
			}

			std::mt19937 generator;
			std::uniform_int_distribution<int> distribution(250, 1000);
			std::this_thread::sleep_for(std::chrono::milliseconds(distribution(generator)));
		}

		emit SigParseUrlFinished(QString(type.first.c_str()));
	}

	emit SigAllGachaParseFinished();
}

Q_INVOKABLE QString& parseGachaUrl::GetUrl()
{
	return _url;
}

QString parseGachaUrl::splitUrl(QString& url)   
{
	int pos = url.indexOf(start_param.c_str());
	if (pos == -1) {
		qDebug() << "Parse Url Error, don't find correct start_param position in string \"" << url << "\"";
		return "";
	}

	QString res = url.mid(pos, url.size() - pos - 2);

	return res;
}

QString parseGachaUrl::getPage(const QString page, const QString gacha_type, const QString end_id)
{
	QString separator = "&";
	QString version_switch = "3.4.0";
	QString size = "20";

	/*&page=1&size=5&gacha_type=11&version_switch=3.4.0&end_id=0*/
	QString res =
		separator + "page=" + page +
		separator + "size=" + size +
		separator + "gacha_type=" + gacha_type +
		separator + "version_switch=" + version_switch +
		separator + "end_id=" + end_id;
	return res;
}
