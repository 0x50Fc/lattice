<?php

require_once '../com.wodoop.mobile.mapmessage/config.php';
require_once '../com.wodoop.mobile.mapmessage/error.php';

require_once '../com.wodoop.mobile.mapmessage/db/DeviceEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/DeviceSyncEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/UserAuthEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/UserEntity.php';

require_once '../com.wodoop.mobile.mapmessage/tasks/SMSTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/UserRegisterTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/AdminRegisterTask.php';

require_once '../com.wodoop.mobile.mapmessage/services/SMSService.php';
require_once '../com.wodoop.mobile.mapmessage/services/UserRegisterService.php';
require_once '../com.wodoop.mobile.mapmessage/services/AdminRegisterService.php';

require_once '../com.wodoop.sms/emy/Client.php';
require_once '../com.wodoop.sms/Vconfig.php';
require_once '../com.wodoop.sms/send.php';

defaultDBAdapter(DB_MYSQL,"localhost:3306","mm","root","root");

getDefaultDBAdapter()->setCharset($dbConfig["charset"]);

getDefaultDBContext()->registerEntity("DeviceEntity");
getDefaultDBContext()->registerEntity("DeviceSyncEntity");
getDefaultDBContext()->registerEntity("UserAuthEntity");
getDefaultDBContext()->registerEntity("AppVersionEntity");
getDefaultDBContext()->registerEntity("UserEntity");
getDefaultDBContext()->registerEntity("MessageEntity");

function config_mm_register(){
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
				"class" => "AdminRegisterService",
				"tasks" => array(
					"AdminRegisterTask"
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