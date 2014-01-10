//
//  LABeaconListViewController.m
//  Lattice
//
//  Created by ioshack on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LABeaconListViewController.h"

@interface LABeaconListViewController ()
@property (nonatomic,strong) NSTimer * timer;
@end

@implementation LABeaconListViewController

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
    // Do any additional setup after loading the view from its nib.
    [_tableDataController reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self beginRefresh];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self endRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginRefresh {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5
                                            target:self
                                            selector:@selector(handleMaxShowTimer:)
                                            userInfo:nil
                                            repeats:YES];
}

- (void)endRefresh {
    [_timer invalidate];
    self.timer = nil;
}

- (void)handleMaxShowTimer:(NSTimer *)theTimer
{
    [_tableDataController reloadData];
}

@end
