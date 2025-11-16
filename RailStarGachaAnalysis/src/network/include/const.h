#include <string>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonArray>
#include <map>

const std::string mihoyoHost = "https://public-operation-hkrpg.mihoyo.com";

const std::string get_url = "/common/gacha_record/api/getGachaLog?win_direction=landscape&";

const std::string start_param = "authkey_ver";

const std::string serverAdd = "127.0.0.1";
const std::string serverPort = "8080";

const std::map<std::string, std::string> Gacha_Type = {
	{ "NewbieGacha", "2" },     //新手池
	{ "UpGacha", "11" },        //up角色池
	{ "UpWeaponGacha", "12" },  //up武器池
	{ "ConstGacha", "1" },      //常驻池
	{ "LinkageGacha", "21" },     //联动角色池
	{ "LinkageWepGacha", "22" },     //联动武器池
};

const std::string saveDirName = "/saves";

const std::map <QString, QString> ConstGachaRole = {
	{ QString::fromLocal8Bit("希儿") , "希儿" },
	{ QString::fromLocal8Bit("刃") , "刃" },
	{ QString::fromLocal8Bit("符玄") , "符玄" },
	{ QString::fromLocal8Bit("克拉拉") , "克拉拉" },
	{ QString::fromLocal8Bit("姬子") , "姬子" },
	{ QString::fromLocal8Bit("布洛妮娅"), "布洛妮娅" },
	{ QString::fromLocal8Bit("白露"), "白露" },
	{ QString::fromLocal8Bit("彦卿"), "彦卿" },
	{ QString::fromLocal8Bit("杰帕德") , "杰帕德" },
	{ QString::fromLocal8Bit("瓦尔特") , "瓦尔特" },
};

const std::map <QString, QString> ConstGachaWep = {
	{ QString::fromLocal8Bit("银河铁道之夜") , "银河铁道之夜" },
	{ QString::fromLocal8Bit("无可取代的东西") , "无可取代的东西" },
	{ QString::fromLocal8Bit("但战斗还未结束") , "但战斗还未结束" },
	{ QString::fromLocal8Bit("以世界之名") , "以世界之名" },
	{ QString::fromLocal8Bit("制胜的瞬间") , "制胜的瞬间" },
	{ QString::fromLocal8Bit("如泥酣眠") , "如泥酣眠" },
	{ QString::fromLocal8Bit("时节不居") , "时节不居" },
};