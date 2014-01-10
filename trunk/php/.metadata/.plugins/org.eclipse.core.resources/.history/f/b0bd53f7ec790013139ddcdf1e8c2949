<?php

require_once '../com.wodoop.mobile.efan/config.php';
require_once '../com.wodoop.mobile.efan/error.php';

require_once '../com.wodoop.mobile.efan/db/StateSyncEntity.php';

require_once '../com.wodoop.mobile.efan/tasks/sync/SyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterSyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterStateSyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterNearbyUserTask.php';


require_once '../com.wodoop.mobile.efan/services/sync/MasterNearbyUserService.php';
require_once '../com.wodoop.mobile.efan/services/UserRegisterService.php';


require_once '../com.wodoop.sms/emy/Client.php';
require_once '../com.wodoop.sms/Vconfig.php';
require_once '../com.wodoop.sms/send.php';

getDefaultDBContext()->registerEntity("DeviceEntity");
getDefaultDBContext()->registerEntity("DeviceSyncEntity");
getDefaultDBContext()->registerEntity("UserAuthEntity");
getDefaultDBContext()->registerEntity("AppVersionEntity");
getDefaultDBContext()->registerEntity("StateSyncEntity");

function config_efan_nearby(){
	return array(

		"services" => array(
			array(
				"class" => "MasterNearbyUserService",
				"tasks" => array(
					"MasterNearbyUserTask"
					),
				"config" => array(),
			),
		),
	);
}


?>