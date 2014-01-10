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
require_once "$library/org.hailong.contacts/contacts.php";
require_once "$library/org.hailong.app/app.php";

function config_contact(){
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
					"appid"=>1
				),
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
					"entitys"=>array("DBAccount","DBLog","DBDevice","DBDeviceSync","DBContacts"
					,"DBContactInfo","DBApp","DBAppAuth","DBAppVersion","DBAppDevice"
					,"DBDSDownlinkSync","DBDSUplinkSync","DBDSVersion")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "ContactService",
				"tasks" => array(
					"ContactCreateTask","ContactRemoveTask"
				),
			),
			array(
				"class" => "ContactInfoService",
				"tasks" => array(
					"ContactInfoAddTask","ContactInfoRemoveTask","ContactInfoUpdateTask"
				),
			),
			array(
				"class" => "SyncUplinkService",
				"tasks" => array(
					"ContactSyncTask"
				),
				"config" =>  array(
					"appid" => 1,
					"faces" => array(
						new ContactsSyncFace("contact",SYNC_ETYPE_CONTACT,array(),FaceTypeUplink),
						new ContactInfoSyncFace("contactInfo",SYNC_ETYPE_CONTACT_INFO,array("contact"),FaceTypeUplink),
					),
				),
			),
			array(
				"class" => "SyncDownlinkService",
				"tasks" => array(
					"ContactSyncTask"
				),
				"config" =>  array(
					"appid" => 1,
					"faces" => array(
						new ContactsSyncFace("contact",SYNC_ETYPE_CONTACT,array(),FaceTypeDownlink),
						new ContactInfoSyncFace("contactInfo",SYNC_ETYPE_CONTACT_INFO,array("contact"),FaceTypeDownlink),
					),
				),
			),
		),
	);
}

?>