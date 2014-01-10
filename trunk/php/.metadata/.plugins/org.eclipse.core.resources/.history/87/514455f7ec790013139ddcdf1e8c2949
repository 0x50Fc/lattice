<?php

$mobile_efan = "../../mobile0928/com.wodoop.mobile.efan";

require_once "services/DBService.php";
require_once "tasks/DBContextTask.php";

require_once "{$mobile_efan}/config.php";
require_once "{$mobile_efan}/error.php";

require_once "{$mobile_efan}/db/BusinessEntity.php";
require_once "{$mobile_efan}/db/DeviceEntity.php";
require_once "{$mobile_efan}/db/DeviceSyncEntity.php";
require_once "{$mobile_efan}/db/UserAuthEntity.php";
require_once "{$mobile_efan}/db/ResourceEntity.php";
require_once "{$mobile_efan}/db/AppVersionEntity.php";
require_once "{$mobile_efan}/db/CouponEntity.php";
require_once "{$mobile_efan}/db/ClogEntity.php";
require_once "{$mobile_efan}/db/StateSyncEntity.php";
require_once "{$mobile_efan}/db/VcouponEntity.php";
require_once "{$mobile_efan}/db/ImgEntity.php";
require_once "{$mobile_efan}/db/BrandEntity.php";
require_once "{$mobile_efan}/db/CategaryEntity.php";

require_once "{$mobile_efan}/tasks/UserAuthTask.php";
require_once "{$mobile_efan}/tasks/DeviceAuthTask.php";
require_once "{$mobile_efan}/tasks/SMSTask.php";
require_once "{$mobile_efan}/tasks/sync/SyncTask.php";
require_once "{$mobile_efan}/tasks/sync/UserSyncTask.php";
require_once "{$mobile_efan}/tasks/sync/UserStateSyncTask.php";
require_once "{$mobile_efan}/tasks/AppVersionTask.php";
require_once "{$mobile_efan}/tasks/SearchCouponTask.php";
require_once "{$mobile_efan}/tasks/CategaryTask.php";
require_once "{$mobile_efan}/tasks/CouponDetailTask.php";
require_once "{$mobile_efan}/tasks/CouponDownloadTask.php";
require_once "{$mobile_efan}/tasks/ApplePushTask.php";
require_once "{$mobile_efan}/tasks/CouponShareTask.php";
require_once "{$mobile_efan}/tasks/UserStateTask.php";
require_once "{$mobile_efan}/tasks/UserUploadTask.php";

require_once "{$mobile_efan}/services/UserAuthService.php";
require_once "{$mobile_efan}/services/DeviceAuthService.php";
require_once "{$mobile_efan}/services/SMSService.php";
require_once "{$mobile_efan}/services/AppVersionService.php";
require_once "{$mobile_efan}/services/sync/UserSyncService.php";
require_once "{$mobile_efan}/services/sync/UserCouponSyncService.php";
require_once "{$mobile_efan}/services/sync/BusinessSyncByUserService.php";
require_once "{$mobile_efan}/services/SearchCouponService.php";
require_once "{$mobile_efan}/services/CategaryService.php";
require_once "{$mobile_efan}/services/CouponDetailService.php";
require_once "{$mobile_efan}/services/CouponDownloadService.php";
require_once "{$mobile_efan}/services/sync/UserCouponDownloadSyncService.php";
require_once "{$mobile_efan}/services/sync/BusinessSyncByUserDownloadService.php";
require_once "{$mobile_efan}/services/ApplePushService.php";
require_once "{$mobile_efan}/services/CouponShareService.php";
require_once "{$mobile_efan}/services/UserStateService.php";
require_once "{$mobile_efan}/services/UserUploadService.php";
require_once "{$mobile_efan}/services/sync/UserInfoSyncService.php";

require_once "{$mobile_efan}/services/sync/UserOrderSyncService.php";
require_once "{$mobile_efan}/services/sync/UserProductSyncService.php";

require_once "{$mobile_efan}/services/trade/CouponTradeSyncService.php";
require_once "{$mobile_efan}/services/trade/ProductSearchService.php";
require_once "{$mobile_efan}/services/trade/ProductDetailService.php";

require_once "{$mobile_efan}/tasks/trade/CouponTradePublishSyncTask.php";
require_once "{$mobile_efan}/tasks/trade/CouponTradeEndSyncTask.php";
require_once "{$mobile_efan}/tasks/trade/CouponTradeBuySyncTask.php";
require_once "{$mobile_efan}/tasks/trade/ProductSearchTask.php";
require_once "{$mobile_efan}/tasks/trade/ProductDetailTask.php";

require_once '../error.php';
require_once '../tasks/TaskException.php';

require_once '../tasks/AuthTask.php';

require_once '../tasks/credit/CreditTask.php';
require_once '../tasks/credit/CreditException.php';
require_once '../tasks/credit/CreditIncomeTask.php';
require_once '../tasks/credit/CreditLogAddTask.php';
require_once '../tasks/credit/CreditPayValidateTask.php';
require_once '../tasks/credit/CreditPayTask.php';
require_once '../tasks/credit/SysCreditTask.php';

require_once '../tasks/trade/TradeException.php';
require_once '../tasks/trade/TradeTask.php';
require_once '../tasks/trade/coupon/CouponTradePublishTask.php';
require_once '../tasks/trade/coupon/CouponTradeBuyTask.php';
require_once '../tasks/trade/coupon/CouponTradeEndTask.php';

require_once '../tasks/trade/product/ProductBuyValidateTask.php';
require_once '../tasks/trade/product/ProductBuyTask.php';
require_once '../tasks/trade/product/ProductPublishTask.php';
require_once '../tasks/trade/product/ProductEndTask.php';
require_once '../tasks/trade/product/ProductRepublishTask.php';

require_once '../tasks/trade/order/OrderCreateTask.php';
require_once '../tasks/trade/order/OrderCancelTask.php';
require_once '../tasks/trade/order/OrderChangeTask.php';
require_once '../tasks/trade/order/OrderPayTask.php';

require_once '../services/credit/CreditLogService.php';
require_once '../services/credit/CreditService.php';
require_once '../services/credit/SysCreditService.php';

require_once '../services/trade/CouponTradeService.php';
require_once '../services/trade/ProductService.php';
require_once '../services/trade/OrderService.php';

require_once "../db/CreditLogEntity.php";
require_once "../db/OrderEntity.php";
require_once "../db/ProductEntity.php";
require_once "../db/SysCreditEntity.php";
require_once "../db/UserEntity.php";

define("VENDOR","../sms/");

require_once "../sms/emy/Client.php";
require_once "../sms/Vconfig.php";
require_once "../sms/send.php";

define('COUPON',1);

$database = require ('../db.config.php');

defaultDBAdapter(DB_MYSQL,$database["DB_HOST"].":".$database["DB_PORT"],$database["DB_NAME"],$database["DB_USER"],$database["DB_PWD"]);

getDefaultDBAdapter()->setCharset($dbConfig["charset"]);

defaultDBContext(new DBContext());

date_default_timezone_set("PRC");



getDefaultDBContext()->registerEntity("DeviceEntity");
getDefaultDBContext()->registerEntity("DeviceSyncEntity");
getDefaultDBContext()->registerEntity("UserAuthEntity");
getDefaultDBContext()->registerEntity("AppVersionEntity");

getDefaultDBContext()->registerEntity("OrderEntity");
getDefaultDBContext()->registerEntity("ProductEntity");
getDefaultDBContext()->registerEntity("SysCreditEntity");
getDefaultDBContext()->registerEntity("CreditLogEntity");

function config_efan(){
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "UserAuthTask",
				"default" => array()
			)
		),
		"services" => array(
			array(
				"class" => "CouponShareService",
				"tasks" => array(
					"SyncTask","CouponShareTask"
					),
				"config" => array(),
			),
			array(
				"class" => "DeviceAuthService",
				"tasks" => array(
					"DeviceAuthTask"
					),
				"config" => array(),
			),
			array(
				"class" => "UserAuthService",
				"tasks" => array(
						"UserAuthTask"
					),
				"config" => array(),
			),
			array(
				"class" => "UserSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			
			array(
				"class" => "CouponTradeSyncService",
				"tasks" => array(
						"SyncTask","CouponTradePublishSyncTask","CouponTradeEndSyncTask","CouponTradeBuySyncTask"
				),
				"config" => array(),
			),
	
			array(
				"class" => "UserCouponSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "BusinessSyncByUserService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "SMSService",
				"tasks" => array(
						"SMSTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "AppVersionService",
				"tasks" => array(
					"AppVersionTask"
				),
				"config" => array(),
			),
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
					),
				"config" => array(
					"efan"=> array(
						"type" => DB_MYSQL,
						"servername" => "localhost:3306",
						"database" => "vcheng",
						"username" => "root",
						"password" => "root",
						)
					),
			),
			array(
				"class" => "SearchCouponService",
				"tasks" => array(
					"SyncTask","SearchCouponTask"
				),
				"config" => array(),
			),
			array(
				"class" => "CategaryService",
				"tasks" => array(
					"SyncTask","CategaryTask"
				),
				"config" => array(),
			),
			array(
				"class" => "CouponDetailService",
				"tasks" => array(
					"SyncTask","CouponDetailTask"
				),
				"config" => array(),
			),
			array(
				"class" => "CouponDownloadService",
				"tasks" => array(
					"SyncTask","CouponDownloadTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserCouponDownloadSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "BusinessSyncByUserDownloadService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserStateService",
				"tasks" => array(
						"UserStateTask"
						),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
				),
				"config" => array(
					"host"=>"gateway.push.apple.com",
					"port"=>2195,
					"cert"=>"aps-vcheng.pem",
					"password"=>"wodoop",
				),
				"security"=>true,
			),
			array(
				"class" => "UserUploadService",
				"tasks" => array(
					"SyncTask","UserUploadTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserInfoSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			
			// 交易内部服务
			array(
				"class" => "CreditService",
				"tasks" => array(
					"CreditPayValidateTask","CreditPayTask","CreditIncomeTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "CreditLogService",
				"tasks" => array(
					"CreditLogAddTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "SysCreditService",
				"tasks" => array(
					"SysCreditTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "CouponTradeService",
				"tasks" => array(
					"CouponTradePublishTask","CouponTradeBuyTask","CouponTradeEndTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "ProductService",
				"tasks" => array(
					"ProductBuyTask","ProductBuyValidateTask","ProductEndTask","ProductPublishTask","ProductRepublishTask"
				),
				"config" => array(),
				"security"=>true,
			),
			array(
				"class" => "OrderService",
				"tasks" => array(
					"OrderCreateTask","OrderCancelTask","OrderChangeTask","OrderPayTask"
				),
				"config" => array(),
				"security"=>true,
			),
			// 交易内部服务　END
	

			array(
				"class" => "ProductSearchService",
				"tasks" => array(
						"SyncTask","ProductSearchTask"
				),
				"config" => array(),
			),
			array(
				"class" => "ProductDetailService",
				"tasks" => array(
						"SyncTask","ProductDetailTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserOrderSyncService",
				"tasks" => array(
						"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "UserProductSyncService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
		),
	);
}

?>