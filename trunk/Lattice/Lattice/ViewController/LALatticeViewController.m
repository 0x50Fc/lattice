//
//  LALatticeViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LALatticeViewController.h"
#import "LALatticeBeaconTask.h"
#import "LALatticeBeaconQueryTask.h"

@interface LALatticeViewController ()
@property(nonatomic,retain) LALatticeBeaconQueryTask * beaconQueryTask;
@end

@implementation LALatticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dbChangedAction:) name:LALatticeObjectChangedNotification object:nil];
    
    if(_dataObject == nil){
        self.dataObject = [self.context focusValueForKey:@"latticeObject"];
    }
    
    self.title = self.dataObject.title;
    
    NSString * tintColor = [self.dataObject.infoObject stringValueForKey:@"tintColor"];
    
    if(tintColor){
        
        int r=0,g=0,b=0;
        float a = 1.0;
        
        sscanf([tintColor UTF8String], "#%02x%02x%02x %f",&r,&g,&b,&a);
        
        self.view.tintColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
        
    }
    
    if([self.dataObject.infoObject objectValueForKey:@"settings"]){
        
        VTBarButtonItem * buttonItem = [[VTBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ico_setting.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(doAction:)];
        
        [buttonItem setActionName:@"url"];
        [buttonItem setUserInfo:[NSString stringWithFormat:@"%@/setting",self.alias]];
        
        self.navigationItem.rightBarButtonItem = buttonItem;
        
    }
    [self uploadInfoObject];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LALatticeObjectChangedNotification object:nil];
    [_beaconQueryTask setDelegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadInfoObject {
    if(_dataObject == nil){
        self.dataObject = [self.context focusValueForKey:@"latticeObject"];
    }
    LALatticeBeaconTask * beaconTask = [[LALatticeBeaconTask alloc] init];
    [beaconTask setBeaconKey:[(id<LAContext>)self.context beaconKey]];
    [beaconTask setInfoObject:_dataObject.infoObject];
    [self.context handle:@protocol(ILALatticeBeaconTask) task:beaconTask priority:0];
}

-(void) dbChangedAction:(NSNotification *) notification{
    [_beaconQueryTask setDelegate:nil];
    self.beaconQueryTask = [[LALatticeBeaconQueryTask alloc] init];
    [_beaconQueryTask setBeaconKeys:[[(id<LAContext>)self.context deviceSet] allObjects]];
    [_beaconQueryTask setDelegate:self];
    [self.context handle:@protocol(ILALatticeBeaconQueryTask) task:_beaconQueryTask priority:0];
}

-(void) vtUploadTask:(id<IVTUplinkTask>) uplinkTask didSuccessResults:(id) results forTaskType:(Protocol *) taskType {
    self.infoObjects = [(id<ILALatticeBeaconQueryTask>)uplinkTask infoObjects];
    [(id<ILALatticeBeaconQueryTask>)uplinkTask setDelegate:nil];
}

-(void) vtUploadTask:(id<IVTUplinkTask>) uplinkTask didFailWithError:(NSError *)error forTaskType:(Protocol *)taskType {
    [(id<ILALatticeBeaconQueryTask>)uplinkTask setDelegate:nil];
}

@end
