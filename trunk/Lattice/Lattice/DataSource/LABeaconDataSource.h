//
//  LABeaconDataSource.h
//  Lattice
//
//  Created by ioshack on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>
@import CoreLocation;
@import CoreBluetooth;

@interface LABeaconDataSource : VTDataSource <CLLocationManagerDelegate, CBPeripheralManagerDelegate>

- (void)startRangingForBeacons;
- (void)stopRangingForBeacons;
- (void)startAdvertisingBeacon;
- (void)stopAdvertisingBeacon;

+ (NSDictionary *)detailsStringForBeacon:(CLBeacon *)beacon;

@end
