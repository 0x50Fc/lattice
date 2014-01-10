//
//  LAFallsContainerDataController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAFallsContainerDataController.h"

@implementation LAFallsContainerDataController

-(CGSize) vtContainerLayout:(VTContainerLayout *)containerLayout itemSizeAtIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];

    id widthKey = [self.infoObject objectValueForKey:@"dataWidthKey"];
    id heightKey = [self.infoObject objectValueForKey:@"dataHeightKey"];
    
    CGSize layoutSize = CGSizeMake([(VTFallsContainerLayout *)containerLayout columnWidth], MAXFLOAT);
    
    if(widthKey && heightKey){
        
        id dataItem = [self dataObjectByIndexPath:indexPath];
        
        double width = [dataItem doubleValueForKeyPath:@"widthKey"];
        double height = [dataItem doubleValueForKeyPath:@"heightKey"];
        
        if(width && height){
            layoutSize.height = layoutSize.width * height / width;
        }
        
    }
   
    VTDOMDocument * document = [self documentByIndexPath:indexPath layoutSize:layoutSize];
    
    return [[document rootElement] frame].size;
}

@end
