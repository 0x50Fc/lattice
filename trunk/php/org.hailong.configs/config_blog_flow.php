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
require_once "$library/org.hailong.account.sync/sync.php";
require_once "$library/org.hailong.log/log.php";
require_once "$library/org.hailong.dataspace/dataspace.php";
require_once "$library/org.hailong.device/device.php";
require_once "$library/org.hailong.blog.flow/flow.php";
require_once "$library/org.hailong.app/app.php";

function config_blog_flow(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "AppAuthTask",
				"default" => array(),
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
					"appid"=>60,
					"anonymous" => true,
				),
			),
			array(
				"class" => "AppDevicePushService",
				"tasks" => array(
					"AppDevicePushTask"
				),
				"config" => array(
					"appid"=>60
				),
				"security" => true,
			),
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
				),
				"config" => array(
					"host"=>"gateway.sandbox.push.apple.com",
					"port"=>2195,
					"cert"=>"aps-dev-UserArrang.pem",
					"password"=>"h159951",
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
					"entitys"=>array("DBAccount","DBAccountInfo","DBLog","DBDevice","DBDeviceSync","DBDSDownlinkSync","DBDSUplinkSync","DBDSVersion"
						,"DBBlogFlow","DBBlogFlowIndex"
						,"DBApp","DBAppAuth","DBAppVersion","DBAppDevice","DBTag")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "AccountService",
				"tasks" => array(
					"AccountByIDTask"
				),
				"security" => true,
			),
			array(
				"class" => "AccountInfoService",
				"tasks" => array(
					"AccountInfoAddTask","AccountInfoUpdateTask"
				),
				"security" => true,
			),
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask"
				),
				"security" => true,
			),
			array(
				"class" => "BlogFlowSyncService",
				"tasks" => array(
					"BlogFlowCreateSyncTask","BlogFlowSearchSyncTask","BlogFlowUpdateSyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "SyncUplinkService",
				"tasks" => array(
					"BlogFlowSyncTask","BlogFlowCreateSyncTask","BlogFlowSearchSyncTask","BlogFlowUpdateSyncTask"
				),
				"config" =>  array(
					"appid" => 60,
					"faces" => array(
						new AccountInfoSyncFace("accountInfo",SYNC_ETYPE_ACCOUNT_INFO,array(),FaceTypeUplink),
					),
				),
			),
			array(
				"class" => "SyncDownlinkService",
				"tasks" => array(
					"BlogFlowSyncTask","BlogFlowCreateSyncTask","BlogFlowSearchSyncTask","BlogFlowUpdateSyncTask"
				),
				"config" =>  array(
					"appid" => 60,
					"faces" => array(
						new AccountSyncFace("account",SYNC_ETYPE_ACCOUNT,array(),FaceTypeDownlink),
						new AccountInfoSyncFace("accountInfo",SYNC_ETYPE_ACCOUNT_INFO,array(),FaceTypeDownlink),
					),
				),
			),
		),
	);
}

?>