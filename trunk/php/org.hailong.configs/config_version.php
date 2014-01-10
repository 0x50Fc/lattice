<?php

require_once '../com.wodoop.mobile.efan/config.php';
require_once '../com.wodoop.mobile.efan/error.php';

require_once '../com.wodoop.mobile.efan/db/AppVersionEntity.php';

require_once '../com.wodoop.mobile.efan/tasks/AppVersionTask.php';

require_once '../com.wodoop.mobile.efan/services/AppVersionService.php';


getDefaultDBContext()->registerEntity("AppVersionEntity");

function config_version(){
	return array(
		
		"services" => array(
			array(
				"class" => "AppVersionService",
				"tasks" => array(
					"AppVersionTask"
				),
				"config" => array(),
			),
		),
	);
}


?>