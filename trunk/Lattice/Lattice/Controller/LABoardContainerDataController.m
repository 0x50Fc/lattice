//
//  LABoardContainerDataController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LABoardContainerDataController.h"

@interface LABoardContainerDataController(){
    NSInteger _columnIndex;
}

@end

@implementation LABoardContainerDataController


-(NSInteger) numberOfVTContainerLayout:(VTContainerLayout *) containerLayout{
    _columnIndex = 0;
    return [super numberOfVTContainerLayout:containerLayout];
}

-(CGSize) vtContainerLayout:(VTContainerLayout *)containerLayout itemSizeAtIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    id widthKey = [self.infoObject objectValueForKey:@"dataWidthKey"];
    id heightKey = [self.infoObject objectValueForKey:@"dataHeightKey"];
    
    CGSize size = containerLayout.size;
    
    NSInteger columnCount = 3;
    
    CGFloat columnWidth = size.width / columnCount;
    
    CGFloat defaultHeight = 160;
    
    CGSize layoutSize = CGSizeMake(columnWidth, defaultHeight);
   
    if(widthKey && heightKey){
        
        id dataItem = [self dataObjectByIndexPath:indexPath];
        
        double width = [dataItem doubleValueForKeyPath:widthKey];
        double height = [dataItem doubleValueForKeyPath:heightKey];
        
        if(width && height){
            
            if(_columnIndex == 0 && width >= size.width * 1.8){
                return CGSizeMake(size.width, size.width * height / width);
            }
            
            if(_columnIndex < columnCount - 1){
                _columnIndex = ( _columnIndex + 2 ) % columnCount;
                return CGSizeMake(columnWidth * 2, defaultHeight);
            }
            
            _columnIndex = ( _columnIndex + 1 ) % columnCount;
            
            return CGSizeMake(columnWidth, defaultHeight);
        }
        
    }
    
    VTDOMDocument * document = [self documentByIndexPath:indexPath layoutSize:layoutSize];
    
    return [[document rootElement] frame].size;
}


@end
