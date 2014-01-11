//
//  LALatticeBeaconTask.h
//  Lattice
//
//  Created by zhang hailong on 14-1-11.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>

@protocol ILALatticeBeaconTask <IVTUplinkTaskDelegate>

@property(nonatomic,retain) NSString * beaconKey;
@property(nonatomic,retain) id infoObject;

@end

@interface LALatticeBeaconTask : VTUplinkTask<ILALatticeBeaconTask>

@end
