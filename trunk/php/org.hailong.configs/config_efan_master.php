<?php

require_once '../com.wodoop.mobile.efan/config.php';
require_once '../com.wodoop.mobile.efan/error.php';

require_once '../com.wodoop.mobile.efan/db/BusinessEntity.php';
require_once '../com.wodoop.mobile.efan/db/DeviceEntity.php';
require_once '../com.wodoop.mobile.efan/db/DeviceSyncEntity.php';
require_once '../com.wodoop.mobile.efan/db/UserAuthEntity.php';
require_once '../com.wodoop.mobile.efan/db/UserEntity.php';
require_once '../com.wodoop.mobile.efan/db/ResourceEntity.php';
require_once '../com.wodoop.mobile.efan/db/AppVersionEntity.php';
require_once '../com.wodoop.mobile.efan/db/CouponEntity.php';
require_once '../com.wodoop.mobile.efan/db/ClogEntity.php';
require_once '../com.wodoop.mobile.efan/db/StateSyncEntity.php';
require_once '../com.wodoop.mobile.efan/db/CategaryEntity.php';

require_once '../com.wodoop.mobile.efan/tasks/BusinessAuthTask.php';
require_once '../com.wodoop.mobile.efan/tasks/DeviceAuthTask.php';
require_once '../com.wodoop.mobile.efan/tasks/SMSTask.php';
require_once '../com.wodoop.mobile.efan/tasks/BusinessMessageTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/SyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterSyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterStateSyncTask.php';
require_once '../com.wodoop.mobile.efan/tasks/sync/MasterNearbyUserTask.php';
require_once '../com.wodoop.mobile.efan/tasks/AppVersionTask.php';
require_once '../com.wodoop.mobile.efan/tasks/UserStateTask.php';
require_once '../com.wodoop.mobile.efan/tasks/coupon/CouponValidateTask.php';
require_once '../com.wodoop.mobile.efan/tasks/coupon/CouponRecvTask.php';
require_once '../com.wodoop.mobile.efan/tasks/coupon/CouponSendTask.php';
require_once '../com.wodoop.mobile.efan/tasks/ApplePushTask.php';
require_once '../com.wodoop.mobile.efan/tasks/CategaryTask.php';

require_once '../com.wodoop.mobile.efan/services/BusinessAuthService.php';
require_once '../com.wodoop.mobile.efan/services/DeviceAuthService.php';
require_once '../com.wodoop.mobile.efan/services/SMSService.php';
require_once '../com.wodoop.mobile.efan/services/BusinessMessageService.php';
require_once '../com.wodoop.mobile.efan/services/sync/BusinessSyncService.php';
require_once '../com.wodoop.mobile.efan/services/sync/BusinessResourceSyncService.php';
require_once '../com.wodoop.mobile.efan/services/AppVersionService.php';
require_once '../com.wodoop.mobile.efan/services/UserStateService.php';
require_once '../com.wodoop.mobile.efan/services/sync/CouponSyncService.php';
require_once '../com.wodoop.mobile.efan/services/sync/MasterNearbyUserService.php';
require_once '../com.wodoop.mobile.efan/services/CouponService.php';
require_once '../com.wodoop.mobile.efan/services/CategaryService.php';
require_once '../com.wodoop.mobile.efan/services/ApplePushService.php';

require_once '../com.wodoop.sms/emy/Client.php';
require_once '../com.wodoop.sms/Vconfig.php';
require_once '../com.wodoop.sms/send.php';

getDefaultDBContext()->registerEntity("DeviceEntity");
getDefaultDBContext()->registerEntity("DeviceSyncEntity");
getDefaultDBContext()->registerEntity("UserAuthEntity");
getDefaultDBContext()->registerEntity("AppVersionEntity");
getDefaultDBContext()->registerEntity("StateSyncEntity");
getDefaultDBContext()->registerEntity("ResourceEntity");

function config_efan_master(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "BusinessAuthTask",
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
				"class" => "BusinessAuthService",
				"tasks" => array(
						"BusinessAuthTask"
					),
				"config" => array(),
			),
			array(
				"class" => "BusinessSyncService",
				"tasks" => array(
						"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "BusinessResourceSyncService",
				"tasks" => array(
						"SyncTask"
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
				"class" => "UserStateService",
				"tasks" => array(
						"UserStateTask"
						),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
				),
				"config" => array(
					"host"=>"gateway.push.apple.com",
					"port"=>2195,
					"cert"=>"aps-vcheng.pem",
					"password"=>"wodoop",
				),
				"security"=>true,
			),
			array(
				"class" => "BusinessMessageService",
				"tasks" => array(
						"BusinessMessageTask"
						),
				"config" => array(),
			),
			array(
				"class" => "AppVersionService",
				"tasks" => array(
					"AppVersionTask"
				),
				"config" => array(),
			),
			array(
				"class" => "CouponSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "CouponService",
				"tasks" => array(
					"SyncTask","CouponValidateTask","CouponRecvTask","CouponSendTask"
				),
				"config" => array(),
			),
			array(
				"class" => "MasterNearbyUserService",
				"tasks" => array(
					"SyncTask","MasterNearbyUserTask"
				),
				"config" => array(),
			),
		),
	);
}


?>