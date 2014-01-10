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
require_once "$library/org.hailong.log/log.php";
require_once "$library/org.hailong.tag/tag.php";
require_once "$library/org.hailong.configs/xunsearch.php";

function config_tag(){
	return array(
		"services" => array(
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask","TagMatchTask"
				),
				"config" => array(
					"output"=>true
				),
			),
		),
	);
}

?>