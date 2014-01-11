//
//  LALatticeBeaconQueryTask.h
//  Lattice
//
//  Created by zhang hailong on 14-1-11.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>

@protocol ILALatticeBeaconQueryTask <IVTUplinkTask>

@property(nonatomic,retain) NSArray * beaconKeys;

// 输出
@property(nonatomic,retain) NSDictionary * infoObjects;

@end

@interface LALatticeBeaconQueryTask : VTUplinkTask<ILALatticeBeaconQueryTask>

@end
