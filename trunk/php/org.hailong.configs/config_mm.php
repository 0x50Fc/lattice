<?php

require_once '../com.wodoop.mobile.mapmessage/config.php';
require_once '../com.wodoop.mobile.mapmessage/error.php';

require_once '../com.wodoop.mobile.mapmessage/db/AppVersionEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/DeviceEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/DeviceSyncEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/UserAuthEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/UserEntity.php';
require_once '../com.wodoop.mobile.mapmessage/db/MessageEntity.php';

require_once '../com.wodoop.mobile.mapmessage/tasks/UserAuthTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/SyncTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/SearchTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/PublishTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/DeviceAuthTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/SMSTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/AppVersionTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/SyncTask.php';
require_once '../com.wodoop.mobile.mapmessage/tasks/UserUploadTask.php';

require_once '../com.wodoop.mobile.mapmessage/services/UserAuthService.php';
require_once '../com.wodoop.mobile.mapmessage/services/PublishService.php';
require_once '../com.wodoop.mobile.mapmessage/services/DeviceAuthService.php';
require_once '../com.wodoop.mobile.mapmessage/services/SMSService.php';
require_once '../com.wodoop.mobile.mapmessage/services/AppVersionService.php';
require_once '../com.wodoop.mobile.mapmessage/services/SearchService.php';
require_once '../com.wodoop.mobile.mapmessage/services/UserSyncService.php';
require_once '../com.wodoop.mobile.mapmessage/services/UserUploadService.php';

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

function config_mm(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "UserAuthTask",
				"default" => array()
			)
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
				"class" => "UserAuthService",
				"tasks" => array(
						"UserAuthTask"
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
			array(
				"class" => "AppVersionService",
				"tasks" => array(
					"AppVersionTask"
				),
				"config" => array(),
			),
			array(
				"class" => "PublishService",
				"tasks" => array(
					"SyncTask","PublishTask"
				),
				"config" => array(),
			),
			array(
				"class" => "SearchService",
				"tasks" => array(
					"SyncTask","SearchTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserUploadService",
				"tasks" => array(
					"SyncTask","UserUploadTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
		),
	);
}


?>