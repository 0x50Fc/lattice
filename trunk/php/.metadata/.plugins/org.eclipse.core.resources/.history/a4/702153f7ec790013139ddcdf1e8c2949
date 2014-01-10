<?php

global $library;

if(!$library){
	$library = "..";
}

require_once "$library/org.hailong.service/service.php";
require_once "$library/org.hailong.word/word.php";


$dbConfig = require "$library/org.hailong.configs/db_default.php";

defaultDBAdapter($dbConfig["type"],$dbConfig["servername"],$dbConfig["database"],$dbConfig["username"],$dbConfig["password"]);

getDefaultDBAdapter()->setCharset($dbConfig["charset"]);

defaultDBContext(new DBContext());

date_default_timezone_set("PRC");


function config_word(){
	global $library;
	
	return array(
		"services" => array(
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBWord")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "WordService",
				"tasks" => array(
					"WordImportTask","WordSplitTask"
				),
				"config" => array(
					"base" => "$library/org.hailong.configs/"
				),
			),
		),
	);
}

?>