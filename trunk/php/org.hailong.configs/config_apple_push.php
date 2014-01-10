<?php

    global $library;
    
    if(!$library){
        $library = "..";
    }
    
    require_once "$library/org.hailong.apple/apple.php";

function config_apple_push(){
	global $library;
	return array(
		"begin-tasks" => array(

		),
		"services" => array(
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
					),
				"config" => array(
					"host"=>"gateway.sandbox.push.apple.com",
					"port"=>2195,
					"cert"=> dirname($_SERVER["SCRIPT_FILENAME"])."/$library/org.hailong.configs/aps-family-dev.pem",
					"password"=>"0p9o8i7u",
				),
			),
		),
	);
}


?>