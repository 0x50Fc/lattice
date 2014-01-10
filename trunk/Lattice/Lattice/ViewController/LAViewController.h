/**
 *  LAViewController.h
 *  Lattice
 *
 *  Created by zhang hailong on 14-1-10.
 *  Copyright 9vteam 2014年. All rights reserved.
 */

#import <vTeam/vTeam.h>

#import "LADBLatticeObject.h"

@interface LAViewController : VTViewController<IVTUplinkTaskDelegate>

@property(nonatomic,retain) IBOutlet VTStatusView * latticeLoadingView;

-(void) openLatticeUrl:(NSString *) url;

-(void) openLatticeObject:(LADBLatticeObject *) dataObject;

@end
