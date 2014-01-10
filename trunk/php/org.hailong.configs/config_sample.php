<?php


function config_sample(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "ValidateTask",
				"default" => array() 
			)
		),
		"end-tasks" => array(
			array(
				"taskType" => "CleanupTask",
				"default" => array()
			)
		),
		"services" => array(
			array(
				"class" => "ValidateService",
				"tasks" => array(
					"ValidateTask"
				),
				"config" => array(),
			),
		),
	);
}

?>