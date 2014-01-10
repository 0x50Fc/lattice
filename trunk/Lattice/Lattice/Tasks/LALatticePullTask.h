//
//  LALatticePullTask.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>

#import "LADBLatticeObject.h"

@protocol ILALatticePullTask <IVTUplinkTask>

// 输入
@property(nonatomic,retain) NSString * url;

// 输出 缓存对象
@property(nonatomic,retain) LADBLatticeObject * dataObject;

// 输出 缓存版本
@property(nonatomic,retain) NSString * version;

@end

@interface LALatticePullTask : VTUplinkTask<ILALatticePullTask>

@end
