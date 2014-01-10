<?php

$mobile_efan = "../../mobile0928/com.wodoop.mobile.efan";

require_once "services/DBService.php";
require_once "tasks/DBContextTask.php";

require_once "{$mobile_efan}/config.php";
require_once "{$mobile_efan}/error.php";

require_once "{$mobile_efan}/db/BusinessEntity.php";
require_once "{$mobile_efan}/db/DeviceEntity.php";
require_once "{$mobile_efan}/db/DeviceSyncEntity.php";
require_once "{$mobile_efan}/db/UserAuthEntity.php";
require_once "{$mobile_efan}/db/UserEntity.php";
require_once "{$mobile_efan}/db/ResourceEntity.php";
require_once "{$mobile_efan}/db/AppVersionEntity.php";
require_once "{$mobile_efan}/db/CouponEntity.php";
require_once "{$mobile_efan}/db/ClogEntity.php";

require_once "{$mobile_efan}/tasks/SMSTask.php";
require_once "{$mobile_efan}/tasks/UserRegisterTask.php";

require_once "{$mobile_efan}/services/SMSService.php";
require_once "{$mobile_efan}/services/UserRegisterService.php";

define("VENDOR","../sms/");

require_once "../sms/emy/Client.php";
require_once "../sms/Vconfig.php";
require_once "../sms/send.php";

define('COUPON',1);

$database = require ('../db.config.php');

defaultDBAdapter(DB_MYSQL,$database["DB_HOST"].":".$database["DB_PORT"],$database["DB_NAME"],$database["DB_USER"],$database["DB_PWD"]);

getDefaultDBAdapter()->setCharset($dbConfig["charset"]);

defaultDBContext(new DBContext());

date_default_timezone_set("PRC");

getDefaultDBContext()->registerEntity("DeviceEntity");
getDefaultDBContext()->registerEntity("DeviceSyncEntity");
getDefaultDBContext()->registerEntity("UserAuthEntity");
getDefaultDBContext()->registerEntity("AppVersionEntity");
getDefaultDBContext()->registerEntity("StateSyncEntity");

function config_efan_register(){
	return array(

		"services" => array(
			array(
				"class" => "UserRegisterService",
				"tasks" => array(
					"UserRegisterTask"
					),
				"config" => array(),
			),
			array(
				"class" => "SMSService",
				"tasks" => array(
						"SMSTask"
						),
				"config" => array(),
				"security"=>true,
			),
		),
	);
}


?>