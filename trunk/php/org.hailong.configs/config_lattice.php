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
require_once "$library/org.hailong.device/device.php";
require_once "$library/org.hailong.uri/uri.php";
require_once "$library/org.hailong.app/app.php";
require_once "$library/org.hailong.authority/authority.php";
require_once "$library/org.hailong.service.async/async.php";
require_once "$library/com.9vteam.lattice/lattice.php";

function config_lattice(){
	
	global $library;
	
	return array(
		"begin-tasks" => array(
			
		),
		"services" => array(
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("LALatticeBeacon"
					)
				),
				"createInstance" =>true,
				"security" => true,
			),
			array(
				"class" => "LALatticeService",
				"tasks" => array(
					"LALatticeBeaconTask","LALatticeBeaconQueryTask"
				),
				"config" => array(),
			),
		),
	);
}

?>