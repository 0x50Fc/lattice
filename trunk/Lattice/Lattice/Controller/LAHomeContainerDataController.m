//
//  LAHomeContainerDataController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-11.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHomeContainerDataController.h"

@implementation LAHomeContainerDataController


-(CGSize) vtContainerLayout:(VTContainerLayout *)containerLayout itemSizeAtIndex:(NSInteger)index{
    
    if(index < [self.headerItemViewControllers count]){
        
        VTItemViewController * itemViewController =[self.headerItemViewControllers objectAtIndex:index];
        
        CGSize itemSize = [itemViewController itemSize];
        
        itemSize.width = [containerLayout size].width;
        
        return itemSize;
    }
    
    CGSize layoutSize = CGSizeMake([containerLayout size].width / 3, INT_MAX);
   
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    VTDOMDocument * document = [self documentByIndexPath:indexPath layoutSize:layoutSize];
    
    return [[document rootElement] frame].size;
}


@end
