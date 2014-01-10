//
//  LAHomeViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHomeViewController.h"

@interface LAHomeViewController ()

@end

@implementation LAHomeViewController

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
    
    self.homeController.context = self.context;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHomeController:nil];
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(![_homeController.dataSource isLoaded] && ![_homeController.dataSource isLoading]){
        [_homeController reloadData];
    }
}

- (IBAction)testAction:(id)sender {
    
    [self openLatticeUrl:@"http://www.lattice.9vteam.com:82/json/image_cw.json"];
    
}

@end
