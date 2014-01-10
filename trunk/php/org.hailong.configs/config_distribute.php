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
require_once "$library/org.hailong.distribute/distribute.php";
require_once "$library/org.hailong.log/log.php";

function config_distribute(){
	return array(
		"services" => array(
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBDistribute")
				),
				"createInstance" =>true,
				"security" => true,
			),
			array(
				"class" => "DistributeService",
				"tasks" => array(
					"DistributeSearchTask"
				),
				"config" => array(),
			),
		),
	);
}

?>