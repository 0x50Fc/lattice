//
//  LABeaconDataController.m
//  Lattice
//
//  Created by ioshack on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LABeaconDataController.h"
#import "LABeaconDataSource.h"

@implementation LABeaconDataController


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    CLBeacon *beacon = [self.dataSource.dataObjects objectAtIndex:indexPath.row];
    NSDictionary *dict = [LABeaconDataSource detailsStringForBeacon:beacon];
    cell.textLabel.text = [dict valueForKey:@"proximity"];
    cell.detailTextLabel.text = [dict valueForKey:@"uuid"];
    return cell;
}

@end
