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
@property(nonatomic,assign) BOOL bShowingBeacon;
@property(nonatomic,retain) UIView *tipView;
@property(nonatomic,retain) NSDictionary *currentDict;
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
    [beaconTask setUrl:_dataObject.url];
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
    if(taskType == @protocol(ILALatticeBeaconQueryTask) || taskType == @protocol(ILALatticeBeaconTask)){
        self.infoObjects = [(id<ILALatticeBeaconQueryTask>)uplinkTask infoObjects];
        [(id<ILALatticeBeaconQueryTask>)uplinkTask setDelegate:nil];
        if (!_bShowingBeacon)
            [self presentBeaconBehavior:0];
    }
    else{
        [super vtUploadTask:uplinkTask didSuccessResults:results forTaskType:taskType];
    }
}

-(void) vtUploadTask:(id<IVTUplinkTask>) uplinkTask didFailWithError:(NSError *)error forTaskType:(Protocol *)taskType {
    if(taskType == @protocol(ILALatticeBeaconQueryTask) || taskType == @protocol(ILALatticeBeaconTask)){
        [(id<ILALatticeBeaconQueryTask>)uplinkTask setDelegate:nil];
    }
    else{
        [super vtUploadTask:uplinkTask didFailWithError:error forTaskType:taskType];
    }
}

-(void)presentBeaconBehavior:(NSInteger)index {
    _bShowingBeacon = YES;
    NSDictionary *dict = nil;
    @synchronized(self) {
        if (index < _infoObjects.count) {
            NSArray *keys = [_infoObjects allKeys];
            NSString *key = [keys objectAtIndex:index];
            if (![[(id<LAContext>)self.context deviceSet] containsObject:key]) {
                dict = nil;
                self.currentDict = nil;
            }
            else {
                dict = [_infoObjects valueForKey:key];
                self.currentDict = dict;
                if ([dict stringValueForKey:@"url"] == nil) {
                    dict = nil;
                    self.currentDict = nil;
                }
                else {
                    if ([_dataObject.url isEqualToString:[dict stringValueForKey:@"url"]]) {
                        dict = nil;
                        self.currentDict = nil;
                    }
                }
            }
        }
    }
    if (dict) {
        BOOL bDoNotDismiss = (index == _infoObjects.count-1);
        if (_tipView) {
            [_tipView removeFromSuperview];
        }
        self.tipView = [[UIView alloc] initWithFrame:CGRectMake(0, -44, self.view.frame.size.width, 44)];
        _tipView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tipButton.frame = _tipView.bounds;
        [tipButton setTitle:[NSString stringWithFormat:@"您身边的人正在阅读:%@,点击查看",[dict stringValueForKeyPath:@"infoObject.title"]] forState:UIControlStateNormal];
        [tipButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [tipButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [tipButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [tipButton addTarget:self action:@selector(tipClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tipView addSubview:tipButton];
        [self.view addSubview:_tipView];
        
//        NSLog(@"AddsubView");
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1.0];
        [_tipView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [UIView commitAnimations];
        
        if (!bDoNotDismiss) {
            __weak UIView * refView = _tipView;
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC);
            dispatch_after(delayTime,dispatch_get_main_queue(),^(void){
                [UIView animateWithDuration:1 animations:^(void){
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                    [refView setFrame:CGRectMake(0, -44, self.view.frame.size.width, 44)];
                } completion:^(BOOL finished) {
                    [refView removeFromSuperview];
                    
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
                    dispatch_after(delayTime,dispatch_get_main_queue(),^(void){
                        [self presentBeaconBehavior:index+1];
                    });
                }];
            });
        }
        else {
            _bShowingBeacon = NO;
        }
    }
    else {
        [UIView animateWithDuration:1 animations:^(void){
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [_tipView setFrame:CGRectMake(0, -44, self.view.frame.size.width, 44)];
        } completion:^(BOOL finished) {
            [_tipView removeFromSuperview];
        }];
        _bShowingBeacon = NO;
    }
}

-(void)tipClick:(id)sender {
    [self openLatticeUrl:[_currentDict stringValueForKey:@"url"]];
}

@end
