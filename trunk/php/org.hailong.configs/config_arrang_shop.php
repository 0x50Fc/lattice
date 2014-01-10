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

function config_arrang_shop(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "AppAuthTask",
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
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthTask"
				),
				"config" => array(
					"appid"=>11
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
				"class" => "LoginService",
				"tasks" => array(
					"LoginTask"
				),
				"security" => true,
			),
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBAccount","DBLog","DBDevice","DBDeviceSync","DBArrang","DBBooking","DBShop","DBShopAuth","DBApp","DBAppAuth","DBAppVersion","DBAppDevice")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "ShopService",
				"tasks" => array(
					"ShopByIDTask","ShopAuthTask"
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
					"appid"=>11
				),
			),
			array(
				"class" => "ShopArrangService",
				"tasks" => array(
					"ShopSyncTask","ShopArrangCheckinTask","ShopArrangTimeoutTask","ShopArrangAddTask"
				),
			),
			array(
				"class" => "ShopSyncService",
				"tasks" => array(
					"ShopSyncTask"
				),
			),
			array(
				"class" => "ShopAuthSyncService",
				"tasks" => array(
					"ShopSyncTask"
				),
			),
			array(
				"class" => "ShopArrangSyncService",
				"tasks" => array(
					"ShopSyncTask"
				),
			),
			array(
				"class" => "ShopBookingService",
				"tasks" => array(
					"ShopSyncTask","ShopBookingCheckinTask","ShopBookingTimeoutTask","ShopBookingCancelTask","ShopBookingCreateTask","ShopBookingUpdateTask"
				),
			),
			array(
				"class" => "ShopBookingSyncService",
				"tasks" => array(
					"ShopSyncTask"
				),
			),
		),
	);
}

?>