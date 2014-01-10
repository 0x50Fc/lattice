<?php

require_once '../com.wodoop.mobile.mapmessage/config.php';
require_once '../com.wodoop.mobile.mapmessage/error.php';

require_once '../com.wodoop.mobile.mapmessage/db/UserEntity.php';

require_once '../com.wodoop.mobile.mapmessage/tasks/SMSTask.php';


require_once '../com.wodoop.mobile.mapmessage/services/SMSService.php';

require_once '../com.wodoop.sms/emy/Client.php';
require_once '../com.wodoop.sms/Vconfig.php';
require_once '../com.wodoop.sms/send.php';

function config_sms(){
	return array(
		
		"services" => array(
			array(
				"class" => "SMSService",
				"tasks" => array(
						"SMSTask"
						),
				"config" => array(),
			),
		),
	);
}


?>