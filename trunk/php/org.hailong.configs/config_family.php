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
require_once "$library/org.hailong.device/device.php";
require_once "$library/org.hailong.tag/tag.php";
require_once "$library/org.hailong.uri/uri.php";
require_once "$library/org.hailong.app/app.php";
require_once "$library/org.hailong.authority/authority.php";
require_once "$library/org.hailong.family/family.php";
require_once "$library/org.hailong.service.async/async.php";

function config_family(){
	
	global $library;
	
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
				"security" => true,
			),
			array(
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthTask"
				),
				"config" => array(
					"appid"=>200,
					"anonymous"=>true,
				),
				"security" => true,
			),
			array(
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthRemoveTask"
				),
				"config" => array(
					"appid"=>200,
				)
			),
			array(
				"class" => "AppDeviceService",
				"tasks" => array(
					"AppDeviceTask"
				),
				"config" => array(
					"appid"=>200
				),
				"security" => true,
			),
			
			array(
				"class" => "AppDevicePushService",
				"tasks" => array(
					"AppDevicePushTask"
				),
				"config" => array(
					"appid"=>200
				),
				"security" => true,
			),
			array(
				"class" => "AppUserPushService",
				"tasks" => array(
					"AppUserPushTask"
				),
				"config" => array(
					"appid"=>200,
				),
				"security" => true,
			),
			array(
				"class" => "AsyncTaskService",
				"tasks" => array(
					"AsyncActiveTask"
				),
				"config" => array(
					"config"=>"config_family"
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
					"cert"=> dirname($_SERVER["SCRIPT_FILENAME"])."/$library/org.hailong.configs/aps-family-dev.pem",
					"password"=>"0p9o8i7u",
				),
				"security" => true,
			),
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBAccount","DBAccountBind","DBAccountInfo","DBLog","DBDevice"
						,"DBApp","DBAppAuth","DBAppDevice","DBAppVersion"
						,"DBTag","DBURI"
						,"DBAuthority","DBAuthorityEntity","DBAuthorityRole","DBCache"
						,"DBFamilyUser","DBFamilyHome","DBFamilyUserHome"
						,"DBFamilyDevice","DBFamilyUserRelation")
				),
				"createInstance" =>true,
				"security" => true,
			),
			array(
				"class" => "AuthService",
				"tasks" => array(
					"AuthTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LoginService",
				"tasks" => array(
					"LoginTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "URIService",
				"tasks" => array(
					"URITask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountBindService",
				"tasks" => array(
					"AccountBindGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountInfoService",
				"tasks" => array(
					"AccountInfoGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountService",
				"tasks" => array(
					"AccountByIDTask","AccountIDCheckNickTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountInfoService",
				"tasks" => array(
					"AccountInfoGetTask","AccountInfoPutTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountRegisterService",
				"tasks" => array(
					"AccountRegisterTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AuthorityValidateService",
				"tasks" => array(
					"AuthorityEntityValidateTask","AuthorityRoleValidateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "CacheService",
				"tasks" => array(
					"CacheGetTask","CachePutTask","CacheRemoveTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LogService",
				"tasks" => array(
					"LogTask"
				),
				"config" => array(
					"filter"=>LogLevelError
				),
				"security" => true,
			),
			array(
				"class" => "FAAuthService",
				"tasks" => array(
					"FAAuthTask","FALoginTask","FAUserUpdateTask","FAUserHomeCreateTask","FAUserHomeGetsTask"
				),
			),
			array(
				"class" => "FAUserService",
				"tasks" => array(
					"FAUserTask","FAUserUpdateTask"
				),
			),
			array(
				"class" => "FAUserHomeService",
				"tasks" => array(
					"FAUserHomeGetsTask","FALoginTask","FAUserHomeCreateTask"
				),
			),
			array(
				"class" => "FAMessageService",
				"tasks" => array(
					"FAMessagePushTask"
				),
				"security" => true,
			),
		),
	);
}

?>