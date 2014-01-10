//
//  LAListContainerDataController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAListContainerDataController.h"

@implementation LAListContainerDataController

-(CGSize) vtContainerLayout:(VTContainerLayout *)containerLayout itemSizeAtIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    VTDOMDocument * document = [self documentByIndexPath:indexPath layoutSize:CGSizeMake(containerLayout.size.width, MAXFLOAT)];
    
    return [[document rootElement] contentSize];
}

@end
