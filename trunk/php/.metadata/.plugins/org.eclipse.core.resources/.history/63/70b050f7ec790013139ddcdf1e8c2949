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
require_once "$library/com.9vteam.qdd/qdd.php";
require_once "$library/org.hailong.statistics/statistics.php";

function config_qdd(){
	
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
			array(
				"taskType" => "StatisticsTask",
				"default" => array(
					"target" => "qdd/api",
					"key" => "pv"
				)
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
					"AppAuthTask","AppAutoAuthTask"
				),
				"config" => array(
					"appid"=>500,
					"anonymous"=>true
				),
				"security" => true,
			),
			array(
				"class" => "AppAuthService",
				"tasks" => array(
					"AppAuthRemoveTask"
				),
				"config" => array(
					"appid"=>500,
				)
			),
			array(
				"class" => "AppDeviceService",
				"tasks" => array(
					"AppDeviceTask"
				),
				"config" => array(
					"appid"=>500
				),
				"security" => true,
			),
			
			array(
				"class" => "AppDevicePushService",
				"tasks" => array(
					"AppDevicePushTask"
				),
				"config" => array(
					"appid"=>500
				),
				"security" => true,
			),
			array(
				"class" => "AppUserPushService",
				"tasks" => array(
					"AppUserPushTask"
				),
				"config" => array(
					"appid"=>500,
				),
				"security" => true,
			),
			array(
				"class" => "AsyncTaskService",
				"tasks" => array(
					"AsyncActiveTask"
				),
				"config" => array(
					"config"=>"config_family"
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
					"cert"=> dirname($_SERVER["SCRIPT_FILENAME"])."/$library/org.hailong.configs/qdd-dev.pem",
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
					"entitys"=>array("DBAccount","DBAccountBind","DBAccountInfo","DBLog","DBDevice"
						,"DBApp","DBAppAuth","DBAppDevice","DBAppVersion"
						,"DBTag","DBURI"
						,"DBAuthority","DBAuthorityEntity","DBAuthorityRole","DBCache"
						,"DBLBSSearch","DBLBSSource"
						,"DBTimeline","DBATUser"
						,"DBClassify","DBClassifyKeyword","DBComment"
						,"DBConcern"
						,"DBTop","DBTopItem"
						,"DBBooks"
						,"DBLiked"
						,"DBProduct"
						,"DBTrade"
						,"DBMessage","DBMessageAttach","DBMessageUser","DBMeeting","DBMeetingMember"
						,"QDDPublish","QDDPublishImage","QDDPublishTag","QDDUser","QDDBooksTag","QDDPublishClassify","QDDBooksClassify"
					)
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
					"AccountBindGetTask","AccountBindTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "AccountInfoService",
				"tasks" => array(
					"AccountInfoGetTask"
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
					"AccountRegisterTask","AccountTelRegisterTask","AccountTelVerifyTask"
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
					"StatisticsTask"
				),
				"security" => true,
			),
			array(
				"class" => "ProductService",
				"tasks" => array(
					"ProductGetTask","ProductCreateTask","ProductGetForUpdateTask","ProductPublishTask"
						,"ProductRemoveTask","ProductTradeTask","ProductUnpublishTask","ProductUntradeTask","ProductUpdateTask"
				),
				"security" => true,
			),
			array(
				"class" => "LBSService",
				"tasks" => array(
					"LBSSourceUpdateTask","LBSSourceRemoveTask","LBSSearchTask","LBSDistanceTask"
				),
				"security" => true,
			),
			array(
				"class" => "TimelineService",
				"tasks" => array(
					"TimelineCreateTask","TimelineLastCountTask","TimelineMaxTask","TimelineQueryTask","TimelineRemoveTask"
				),
				"config" => array(
					"dbKey"=>"qdd",
					"dbTable"=>"DBTimeline",
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
				"class" => "ClassifyService",
				"tasks" => array(
					"ClassifyCreateTask","ClassifyChildTask","ClassifyMatchTask"
					,"ClassifyParentTask","ClassifyQueryTask","ClassifyRemoveTask","ClassifyUpdateTask"
					,"ClassifyKeywordAssignTask","ClassifyQueryTopTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TagService",
				"tasks" => array(
					"TagAssignTask","TagTopTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "ConcernService",
				"tasks" => array(
					"ConcernBlockCancelTask","ConcernBlockTask","ConcernCancelTask","ConcernCreateTask","ConcernFetchUserTask"
					,"ConcernCheckTask","ConcernFansCountTask","ConcernFollowCountTask","ConcernIsFollowTask","ConcernFetchFansTask"
					,"ConcernIsFansTask","ConcernIsMutualTask","ConcernMutualCountTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "TopService",
				"tasks" => array(
					"TopItemTask","TopSearchTask","TopRemoveTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "LikedService",
				"tasks" => array(
					"LikeRemoveTask","LikeTask","UnLikeTask","LikeQueryTask","LikeCheckTask","LikedCountTask","LikeUserQueryTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "CommentService",
				"tasks" => array(
					"CommentCreateTask","CommentRemoveTask","CommentQueryTask","CommentGetTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "BooksService",
				"tasks" => array(
					"BooksCreateTask","BooksQueryTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "SinaWeiboLoginService",
				"tasks" => array(
					"SinaWeiboLoginTask","SinaWeiboBindTask"
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
				"class" => "QQLoginService",
				"tasks" => array(
					"QQLoginTask","QQBindTask"
				),
				"config" => array(),
				"security" => true,
			),
			array(
				"class" => "QDDAuthService",
				"tasks" => array(
					"QDDRegisterTask","QDDSearchNearUserTask","QDDAuthTask","QDDGetUserTask"
						,"QDDPublishTask","QDDTimelineTask","QDDUpdateUserTask","QDDLoginTask"
						,"QDDWeiboLoginTask","QDDQQLoginTask","QDDBooksCreateTask","QDDNearTimelineTask"
						,"QDDTimelineTask","QDDFollowTask","QDDUnFollowTask","QDDLikeTask","QDDUnLikeTask"
						,"QDDCommentTask","QDDBooksSearchTask","QDDWeiboBindTask","QDDQQBindTask","QDDUserTimelineTask"
						,"QDDUserDetailsTask","QDDUserConcernTask","QDDUserFansTask"
				),
			),
			array(
				"class" => "QDDBooksService",
				"tasks" => array(
					"QDDBooksCreateTask","QDDBooksSearchTask"
				),
				"config" => array(),
			),
			array(
				"class" => "QDDLBSService",
				"tasks" => array(
					"QDDSearchNearUserTask","QDDNearTimelineTask"
				),
				"config" => array("distance"=>2000),
			),
			array(
				"class" => "QDDClassifyService",
				"tasks" => array(
					"QDDClassifyTask"
				),
			),
			array(
				"class" => "QDDTimelineService",
				"tasks" => array(
					"QDDTimelineTask","QDDUserTimelineTask"
				),
			),
			array(
				"class" => "QDDPublishService",
				"tasks" => array(
					"QDDGetPublishTask"
				),
				"security" => true,
			),
			array(
				"class" => "QDDPublishService",
				"tasks" => array(
					"QDDPublishTask"
				),
			),
			array(
				"class" => "QDDConcernService",
				"tasks" => array(
					"QDDFollowTask","QDDUnFollowTask","QDDUserConcernTask","QDDUserFansTask"
				),
			),
			array(
				"class" => "QDDTopService",
				"tasks" => array(
					"QDDTopTimelineTask"
				),
			),
			array(
				"class" => "QDDLikeService",
				"tasks" => array(
					"QDDLikeTask","QDDUnLikeTask","QDDLikeUserListTask"
				),
			),
			array(
				"class" => "QDDCommentService",
				"tasks" => array(
					"QDDCommentTask","QDDCommentListTask"
				),
			),
			array(
				"class" => "QDDPrizeService",
				"tasks" => array(
					"QDDPrizeSearchTask","QDDPrizeBuyTask"
				),
			),
			array(
				"class" => "QDDMessageService",
				"tasks" => array(
					"QDDMessageSendTask","QDDMessageSearchTask"
				),
			),
		),
	);
}

?>