<?php

require_once 'tasks/DemoTask.php';
require_once 'services/DemoService.php';

function config_demo(){
	return array(
		"services" => array(
			array(
				"class" => "DemoService",
				"tasks" => array(
					"DemoTask"
				),
				"config" => array(),
			),
		),
	);
}

?>