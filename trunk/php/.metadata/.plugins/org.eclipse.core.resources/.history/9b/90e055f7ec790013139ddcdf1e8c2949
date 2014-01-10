<?php

$library = "..";

require_once '../org.hailong.email/email.php';

date_default_timezone_set("PRC");

function config_email(){
	return array(
		
		"services" => array(
			array(
				"class" => "eMailService",
				"tasks" => array(
						"eMailSendTask"
						),
				"config" => array(
					"" => array(
						"from" => "mail@hailong.org",
						"smtp" => "smtp.exmail.qq.com",
						"port" => 25,
						"user" => "mail@hailong.org",
						"password" => "h1234567",
					),
				),
			),
		),
	);
}


?>