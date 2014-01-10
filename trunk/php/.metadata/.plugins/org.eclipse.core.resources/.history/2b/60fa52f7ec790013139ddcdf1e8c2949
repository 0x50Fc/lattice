<?php

    global $library;
    
    if(!$library){
        $library = "..";
    }
    
    require_once "$library/org.hailong.crash/crash.php";

    $dbConfig = require "$library/org.hailong.configs/db_default.php";
    
    defaultDBAdapter($dbConfig["type"],$dbConfig["servername"],$dbConfig["database"],$dbConfig["username"],$dbConfig["password"]);
    
    getDefaultDBAdapter()->setCharset($dbConfig["charset"]);
    
    defaultDBContext(new DBContext());
    
    date_default_timezone_set("PRC");
    
function config_crash(){
	
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
					"entitys"=>array("DBCrash")
				),
				"createInstance" =>true,
			),
			array(
				"class" => "CrashService",
				"tasks" => array(
					"CrashTask"
				),
			),
		),
	);
}


?>