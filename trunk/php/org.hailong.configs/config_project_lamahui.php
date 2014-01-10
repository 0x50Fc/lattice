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

require_once "$library/org.hailong.configs/xunsearch.php";
require_once "$library/org.hailong.service/service.php";
require_once "$library/org.hailong.apple/apple.php";
require_once "$library/org.hailong.account/account.php";
require_once "$library/org.hailong.log/log.php";
require_once "$library/org.hailong.dataspace/dataspace.php";
require_once "$library/org.hailong.device/device.php";
require_once "$library/org.hailong.tag/tag.php";
require_once "$library/org.hailong.uri/uri.php";
require_once "$library/org.hailong.app/app.php";
require_once "$library/org.hailong.authority/authority.php";
require_once "$library/org.hailong.project.lamahui/lamahui.php";
require_once "$library/org.hailong.taobao/taobao.php";
require_once "$library/org.hailong.service.async/async.php";
require_once "$library/org.hailong.log/log.php";

function config_project_lamahui(){
	
	global $library;
	
	return array(
		"begin-tasks" => array(
			array(
				"taskType" => "DeviceAuthTask",
				"default" => array()
			),
			array(
				"taskType" => "AppDeviceTask",
                "default" => array()
			),
			array(
				"taskType" => "AppAuthTask",
				"default" => array()
			),
		),
		"services" => array(
			array(
				"class" => "DeviceAuthService",
				"tasks" => array(
					"DeviceAuthTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthTask"
				),
				"config" => array(
					"appid"=>80,
					"anonymous"=>true,
				),
				"security" => true,
			),
			array(
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthRemoveTask"
				),
				"config" => array(
					"appid"=>80,
				)
			),
			array(
				"class" => "AppDeviceService",
				"tasks" => array(
					"AppDeviceTask"
				),
				"config" => array(
					"appid"=>80
				),
				"security" => true,
			),
			
			array(
				"class" => "AppDevicePushService",
				"tasks" => array(
					"AppDevicePushTask"
				),
				"config" => array(
					"appid"=>80
				),
				"security" => true,
			),
			array(
				"class" => "AppUserPushService",
				"tasks" => array(
					"AppUserPushTask"
				),
				"config" => array(
					"appid"=>80,
				),
				"security" => true,
			),
			array(
				"class" => "AsyncTaskService",
				"tasks" => array(
					"AsyncActiveTask"
				),
				"config" => array(
					"config"=>"config_lamahui"
				),
				"security" => true,
			),
			array(
				"class" => "ApplePushService",
				"tasks" => array(
					"ApplePushTask"
				),
				"config" => array(
					"host"=>"gateway.sandbox.push.apple.com",
					"port"=>2195,
					"cert"=> dirname($_SERVER["SCRIPT_FILENAME"])."/$library/org.hailong.configs/lamahui-dev.pem",
					"password"=>"0p9o8i7u",
				),
				"security" => true,
			),
			array(
				"class" => "DBService",
				"tasks" => array(
					"DBContextTask"
				),
				"config" => array(
					"entitys"=>array("DBAccount","DBAccountBind","DBAccountInfo","DBLog","DBDevice","DBDSDownlinkSync","DBDSUplinkSync","DBDSVersion"
						,"DBApp","DBAppAuth","DBAppDevice","DBAppVersion"
						,"DBTag","DBURI","DBTimeline","DBATUser"
						,"DBAuthority","DBAuthorityEntity","DBAuthorityRole","DBCache"
						,"DBClassify","DBClassifyKeyword","DBComment","DBConcern"
						,"DBLattice","DBLatticeClassify","DBLatticeConcern"
						,"DBLiked","DBShare","DBTopic","DBTopicContent"
						,"DBConcern","DBSpread","DBGoods","DBGoodsClassify","DBGoodsKeyword"
						,"DBIntegral"
						,"DBMessage","DBMeeting","DBMeetingMember","DBMessageAttach","DBMessageUser"
						,"LMDBUserKeyword","LMDBTimeline")
				),
				"createInstance" =>true,
				"security" => true,
			),
			array(
				"class" => "AuthService",
				"tasks" => array(
					"AuthTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LoginService",
				"tasks" => array(
					"LoginTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "URIService",
				"tasks" => array(
					"URITask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountBindService",
				"tasks" => array(
					"AccountBindGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountService",
				"tasks" => array(
					"AccountByIDTask","AccountIDCheckNickTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountInfoService",
				"tasks" => array(
					"AccountInfoGetTask","AccountInfoPutTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountRegisterService",
				"tasks" => array(
					"AccountRegisterTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LMAuthService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMATUserOutputService",
				"tasks" => array(
					"SyncTask","ATUserCreateTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMUserOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
		
			array(
				"class" => "LMUserService",
				"tasks" => array(
					"LMUserTask","LoginTask","LMUserTagTopTask","LMUserTagAssignTask"
				),
				"config" => array(),
				"security" => true,
			),
			
			array(
				"class" => "LMShareTimelineService",
				"tasks" => array(
					"LMShareTimelineUpdateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LMShareTimelineOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMGoodsOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMLatticeOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMShareOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMShareQueryOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMShareDetailOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMFollowOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMCommentOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMIntegralOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMMessageOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "LMTagOutputService",
				"tasks" => array(
					"SyncTask"
				),
				"config" => array(),
			),
			array(
				"class" => "TimelineService",
				"tasks" => array(
					"TimelineCreateTask","TimelineLastCountTask","TimelineMaxTask","TimelineQueryTask","TimelineRemoveTask"
				),
				"config" => array(
					"dbKey"=>"lamahui",
					"dbTable"=>"LMDBTimeline",
				),
				"security" => true,
			),
			array(
				"class" => "ATUserService",
				"tasks" => array(
					"ATUserCreateTask","ATUserRemoveTask","ATUserBodyTask","ATUserFetchTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AuthorityValidateService",
				"tasks" => array(
					"AuthorityEntityValidateTask","AuthorityRoleValidateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "CacheService",
				"tasks" => array(
					"CacheGetTask","CachePutTask","CacheRemoveTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "ClassifyService",
				"tasks" => array(
					"ClassifyCreateTask","ClassifyChildTask","ClassifyMatchTask"
					,"ClassifyParentTask","ClassifyQueryTask","ClassifyRemoveTask","ClassifyUpdateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "CommentService",
				"tasks" => array(
					"CommentCreateTask","CommentRemoveTask","CommentListTask","CommentGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "ConcernService",
				"tasks" => array(
					"ConcernBlockCancelTask","ConcernBlockTask","ConcernCancelTask","ConcernCreateTask","ConcernFetchUserTask"
					,"ConcernCheckTask","ConcernFansCountTask","ConcernFollowCountTask","ConcernIsFollowTask","ConcernFetchFansTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LatticeService",
				"tasks" => array(
					"LatticeBlockTask","LatticeCreateTask","LatticeFollowTask","LatticeQueryTask","LatticeInIDSTask","LatticeRemoveTask"
					,"LatticeUnBlockTask","LatticeUnFollowTask","LatticeUpdateTask","LatticeUserConcernFetchTask"
					,"LatticeUserFollowCountTask","LatticeUserCountTask","LatticeListTask","LatticeContentIncTask"
					,"LatticeLikeTask","LatticeBrowseTask","LatticeIsFollowTask","LatticeLogoSetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LikedService",
				"tasks" => array(
					"LikeRemoveTask","LikeTask","UnLikeTask","LikeQueryTask","LikeCheckTask","LikedCountTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "ShareQueryService",
				"tasks" => array(
					"ShareInIDSTask","ShareTimelineTask","ShareQueryTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "ShareService",
				"tasks" => array(
					"ShareCreateTask","ShareLikeTask","ShareRemoveTask","ShareUnLikeTask","ShareBrowserTask","ShareUserCountTask"
					,"LatticeRemoveTask","ShareGetTask","ShareCommentIncTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TopicService",
				"tasks" => array(
					"TopicBodyTask","TopicContentAddTask","TopicContentRemoveTask","TopicCreateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "GoodsService",
				"tasks" => array(
					"GoodsCreateTask","GoodsImportTask","GoodsBrowserTask","GoodsLikeTask","GoodsForwardTask","GoodsGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "GoodsSpreadService",
				"tasks" => array(
					"GoodsSpreadAskTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "SpreadService",
				"tasks" => array(
					"SpreadAskTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LatticeService",
				"tasks" => array(
					"LatticeCreateTask","LatticeRemoveTask","LatticeQueryTask","LatticeFollowTask","LatticeUnFollowTask"
					,"LatticeBlockTask","LatticeUnBlockTask","LatticeUpdateTask","LatticeGetTask","LatticeClassifyMatchTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask","TagMatchTask","TagTopTask"
				),
				"security" => true,
			),
			array(
				"class" => "IntegralService",
				"tasks" => array(
					"IntegralTotalTask","IntegralIncomeTask","IntegralFetchTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MessageService",
				"tasks" => array(
					"MessageUserAccessTask","MessageUserInvokeTask","AccountBindTask","MessageAccountAuthorizeTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MeetingService",
				"tasks" => array(
					"MeetingMemberTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MessageSendService",
				"tasks" => array(
					"MessageSendTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MessageRemindService",
				"tasks" => array(
					"MessageRemindTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MessageStateService",
				"tasks" => array(
					"MessageStateTask","MessageSessionStateTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "MessageQueryService",
				"tasks" => array(
					"MessageQueryTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LogService",
				"tasks" => array(
					"LogTask"
				),
				"config" => array(
					"filter"=>LogLevelError
				),
				"security" => true,
			),
			array(
				"class" => "StatisticsService",
				"tasks" => array(
					"StatisticsTask",
				),
				"security" => true,
			),
			array(
				"class" => "XSSearchService",
				"tasks" => array(
					"SearchIndexAddTask","SearchIndexUpdateTask","SearchIndexRemoveTask","SearchResultsTask",
				),
				"security" => true,
			),
			array(
				"class" => "SyncUplinkService",
				"tasks" => array(
					"SyncTask"
				),
				"config" =>  array(
					"appid" => 80,
					"faces" => array(
						new LMMessageSyncFace("message",SYNC_ETYPE_MESSAGE,array(),MessageFaceTypeUplink),
					),
				),
			),
			array(
				"class" => "SyncDownlinkService",
				"tasks" => array(
					"SyncTask"
				),
				"config" =>  array(
					"appid" => 80,
					"anonymous" => true,
					"faces" => array(
						new LMUserSyncFace("user",SYNC_ETYPE_USER),
						new ClassifySyncFace("classify",SYNC_ETYPE_CLASSIFY),
						new LMMessageSyncFace("message",SYNC_ETYPE_MESSAGE),
					),
				),
			),
			
		),
	);
}

?>