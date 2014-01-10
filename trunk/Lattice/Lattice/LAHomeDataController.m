//
//  LAHomeDataController.m
//  Lattice
//
//  Created by ioshack on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHomeDataController.h"
#import "LAHomeDataSource.h"
#import "LADBLatticeObject.h"

@implementation LAHomeDataController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        int count = [self.dataSource count];
        if (count == 0) {
            return 0;
        }
        else{
            return count/2 + 1;
        }
    }
    else{
        int count = [[(LAHomeDataSource *)(self.dataSource) historyLattices] count];
        return count/2 + count%2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cell1 = @"cellIdentify1";
    NSString *cell2 = @"cellIdentify2";
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        
        if(cell == nil){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
            
            VTImageView *imageView = [[VTImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
            imageView.tag = 10;
            [cell.contentView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 20)];
            titleLabel.tag = 11;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:titleLabel];
            
        }
        
        return cell;
    }
    else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        
        if(cell == nil){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
            
            VTImageView *imageView1 = [[VTImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 60)];
            imageView1.tag = 10;
            [cell.contentView addSubview:imageView1];
            
            UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 160, 20)];
            titleLabel1.tag = 11;
            titleLabel1.textAlignment = NSTextAlignmentCenter;
            titleLabel1.textColor = [UIColor blackColor];
            titleLabel1.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:titleLabel1];
            
            VTImageView *imageView2 = [[VTImageView alloc] initWithFrame:CGRectMake(160, 0, 160, 60)];
            imageView2.tag = 20;
            [cell.contentView addSubview:imageView2];
            
            UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 60, 160, 20)];
            titleLabel2.tag = 21;
            titleLabel2.textAlignment = NSTextAlignmentCenter;
            titleLabel2.textColor = [UIColor blackColor];
            titleLabel2.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:titleLabel2];
            
        }
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        VTImageView *imageView = (VTImageView *)[cell.contentView viewWithTag:10];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:11];
        NSDictionary *item = [self.dataSource dataObjectAtIndex:0];
        
        imageView.src = [item valueForKey:@"image"];
        if(![imageView isLoading] && ![imageView isLoaded]){
            [imageView setSource:self];
            [self.context handle:@protocol(IVTImageTask) task:imageView priority:0];
        }
        
        titleLabel.text = [item valueForKey:@"title"];
    }
    else if(indexPath.section == 0){
        
        VTImageView *imageView1 = (VTImageView *)[cell.contentView viewWithTag:10];
        UILabel *titleLabel1 = (UILabel *)[cell.contentView viewWithTag:11];
        NSDictionary *item1 = [self.dataSource dataObjectAtIndex:((indexPath.row-1)*2 + 1)];
        
        imageView1.src = [item1 valueForKey:@"image"];
        if(![imageView1 isLoading] && ![imageView1 isLoaded]){
            [imageView1 setSource:self];
            [self.context handle:@protocol(IVTImageTask) task:imageView1 priority:0];
        }
        
        titleLabel1.text = [item1 valueForKey:@"title"];
        
        if ([self.dataSource count]-1 >= ((indexPath.row-1)*2 + 2)) {
            VTImageView *imageView2 = (VTImageView *)[cell.contentView viewWithTag:20];
            UILabel *titleLabel2 = (UILabel *)[cell.contentView viewWithTag:21];
            NSDictionary *item2 = [self.dataSource dataObjectAtIndex:((indexPath.row-1)*2 + 1)];
            
            imageView2.src = [item2 valueForKey:@"image"];
            if(![imageView2 isLoading] && ![imageView2 isLoaded]){
                [imageView2 setSource:self];
                [self.context handle:@protocol(IVTImageTask) task:imageView2 priority:0];
            }
            
            titleLabel2.text = [item2 valueForKey:@"title"];
        }
    }
    else{
        
        VTImageView *imageView1 = (VTImageView *)[cell.contentView viewWithTag:10];
        UILabel *titleLabel1 = (UILabel *)[cell.contentView viewWithTag:11];
        LADBLatticeObject *item1 = [[(LAHomeDataSource *)(self.dataSource) historyLattices] objectAtIndex:indexPath.row*2];
        
        imageView1.src = item1.image;
        if(![imageView1 isLoading] && ![imageView1 isLoaded]){
            [imageView1 setSource:self];
            [self.context handle:@protocol(IVTImageTask) task:imageView1 priority:0];
        }
        
        titleLabel1.text = item1.title;
        
        if ([[(LAHomeDataSource *)(self.dataSource) historyLattices] count]-1 >= (indexPath.row*2 + 1)) {
            VTImageView *imageView2 = (VTImageView *)[cell.contentView viewWithTag:20];
            UILabel *titleLabel2 = (UILabel *)[cell.contentView viewWithTag:21];
            LADBLatticeObject *item2 = [[(LAHomeDataSource *)(self.dataSource) historyLattices] objectAtIndex:(indexPath.row*2 + 1)];
            
            imageView2.src = item2.image;
            if(![imageView2 isLoading] && ![imageView2 isLoaded]){
                [imageView2 setSource:self];
                [self.context handle:@protocol(IVTImageTask) task:imageView2 priority:0];
            }
            
            titleLabel2.text = item2.title;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"九格推荐";
    }
    else{
        return @"历史记录";
    }
}

@end
