/**
 *  LAContext.h
 *  Lattice
 *
 *  Created by zhang hailong on 14-1-10.
 *  Copyright 9vteam 2014年. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import "NSError+LA.h"

#define LALatticeObjectChangedNotification @"LALatticeObjectChangedNotification"
#define LALatticeObjectKey                 @"dataObject"
#define LALatticeVersionKey                @"version"
#define LALatticeUUID                      @"0BD2DCDA-7B76-4233-9FBB-F402848BF8FE"
#define LALatticeIdentifier                @"com.sina.Lattice"

@protocol LAContext <IVTUIContext>

@property (nonatomic,readonly) VTDBContext         *appDBContext;
@property (nonatomic,copy    ) NSString            *beaconKey;
@property (nonatomic,strong  ) NSMutableSet        *deviceSet;

- (void)setDeviceSet:(NSMutableSet*)deviceSet;

@end
