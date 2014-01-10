/**
 *  LAShell.h
 *  Lattice
 *
 *  Created by zhang hailong on 14-1-10.
 *  Copyright 9vteam 2014年. All rights reserved.
 */


#import <UIKit/UIKit.h>
#import <vTeam/vTeam.h>
#import "LAContext.h"
#import "LABeaconDataSource.h"

@interface LAShell : VTShell<UIApplicationDelegate,LAContext> {
    
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet LABeaconDataSource *beaconMonitor;

@end
