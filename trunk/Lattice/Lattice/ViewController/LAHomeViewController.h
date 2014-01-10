//
//  LAHomeViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"
#import "LAHomeDataController.h"

@interface LAHomeViewController : LAViewController
@property(nonatomic,retain) IBOutlet LAHomeDataController *homeController;

- (IBAction)testAction:(id)sender;

@end
