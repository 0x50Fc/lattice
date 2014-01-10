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
#define LALatticeObjectKey  @"dataObject"
#define LALatticeVersionKey @"version"

@protocol LAContext <IVTUIContext>

@property(nonatomic,readonly) VTDBContext * appDBContext;

@end
