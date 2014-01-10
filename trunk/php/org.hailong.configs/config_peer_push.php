<?php

    global $library;
    
    if(!$library){
        $library = "..";
    }
    
    require_once "$library/org.hailong.peer/peer.php";

function config_peer_push(){
	return array(
		"begin-tasks" => array(

		),
		"services" => array(
			array(
				"class" => "PeerPushService",
				"tasks" => array(
					"PeerPushTask"
					),
				"config" => array(
					"host"=>"localhost",
					"port"=>3910,
					"peer-uri"=>"org.hailong.push",
				),
			),
		),
	);
}


?>