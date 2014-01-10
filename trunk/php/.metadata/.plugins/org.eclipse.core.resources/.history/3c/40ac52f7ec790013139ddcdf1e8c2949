<?php

global $library;

if(!$library){
	$library = "..";
}

$dbConfig = require "$library/org.hailong.configs/db_default.php";

defaultDBAdapter($dbConfig["type"],$dbConfig["servername"],$dbConfig["database"],$dbConfig["username"],$dbConfig["password"]);

getDefaultDBAdapter()->setCharset($dbConfig["charset"]);

defaultDBContext(new DBContext());

date_default_timezone_set("PRC");


require_once "$library/org.hailong.service/service.php";
require_once "$library/org.hailong.apple/apple.php";
require_once "$library/org.hailong.account/account.php";
require_once "$library/org.hailong.log/log.php";
require_once "$library/org.hailong.dataspace/dataspace.php";
require_once "$library/org.hailong.device/device.php";
require_once "$library/org.hailong.shop/shop.php";
require_once "$library/org.hailong.arrang/arrang.php";
require_once "$library/org.hailong.app/app.php";

function config_arrang(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "AppDeviceTask",
                "default" => array()
			),
		),
		"services" => array(
			array(
				"class" => "DeviceAuthService",
				"tasks" => array(
					"DeviceAuthTask"
				),
				"config" => array(),
			),
			array(
				"class" => "AppDeviceService",
				"tasks" => array(
					"AppDeviceTask"
				),
				"config" => array(
					"appid"=>12
				),
			),
			array(
				"class" => "AppDevicePushService",
				"tasks" => array(
					"AppDevicePushTask"
				),
				"config" => array(
						"appid"=>12
				),
				"security" => true,
			),
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
				),
				"config" => array(
					"host"=>"gateway.push.apple.com",
					"port"=>2195,
					"cert"=>"aps-paipaizuo.pem",
					"password"=>"Ktp100491",
				),
				"security" => true,
			),
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBAccount","DBLog","DBDevice","DBDeviceSync","DBArrang","DBShop","DBShopAuth","DBApp","DBAppAuth","DBAppDevice","DBAppVersion")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "ShopService",
				"tasks" => array(
					"ShopByIDTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "SyncService",
				"tasks" => array(
					"VersionTask","SyncEntityAccessTask","SyncEntityCleanupTask"
					,"SyncEntityLastTimestampTask","SyncEntityQueryTask","SyncEntityVersionTask","SyncEntityLimitTask"
				),
				"config" => array(
					"appid"=>12
				),
			),
			array(
				"class" => "UserArrangSyncService",
				"tasks" => array(
					"UserSyncTask","UserGetArrangNumberTask","UserArrangCancelTask","UserAssignShopTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserArrangShopSyncService",
				"tasks" => array(
					"UserSyncTask"
				),
				"config" => array(),
			),
		),
	);
}

?>