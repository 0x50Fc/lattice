//
//  LALatticeViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"

@interface LALatticeViewController : LAViewController <IVTUplinkTaskDelegate>

@property(nonatomic,retain) LADBLatticeObject * dataObject;

@property(nonatomic,retain) NSDictionary * infoObjects;

- (void)uploadInfoObject;

@end
