//
//  LAContainerDataController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAContainerDataController.h"

@implementation LAContainerDataController


-(VTDOMDocument *) documentByIndexPath:(NSIndexPath *) indexPath layoutSize:(CGSize) layoutSize{
    
    id dataItem = [self dataObjectByIndexPath:indexPath];
    
    if([dataItem isKindOfClass:[NSMutableDictionary class]]){
        
        VTDOMDocument * document = [dataItem valueForKey:@"__document__"];
        
        if(document == nil){
            
            document = [[VTDOMDocument alloc] init];
            
            VTDOMParse * parse = [[VTDOMParse alloc] init];
            
            [parse parseHTML:[self htmlContentByIndexPath:indexPath] toDocument:document];
            
            [self document:document willLoadDataObject:dataItem];
            
            [document setStyleSheet:self.styleSheet];
            
            [dataItem setValue:document forKey:@"__document__"];
            
            document.indexPath = indexPath;
            
            [self document:document didLoadedDataObject:dataItem];
            
            [document.rootElement layout:layoutSize];
            
            [self downloadImagesForElement:document.rootElement];
            
            [dataItem setObject:document.rootElement forKey:@"element"];
            
        }
        
        return document;
    }
    
    return nil;
}

-(VTItemViewController *) vtContainerView:(VTContainerView *)containerView itemViewAtIndex:(NSInteger)index frame:(CGRect)frame{
    
    VTItemViewController * itemViewController = [super vtContainerView:containerView
                                                       itemViewAtIndex:index frame:frame];
    
    for(VTDOMView * view in [[itemViewController view] searchViewForClass:[VTDOMView class]]){
        [view setDelegate:self];
    }
    
    return itemViewController;
}

-(void) loadImagesForElement:(VTDOMElement *) element{
    
    if([element isKindOfClass:[VTDOMImageElement class]]){
        
        VTDOMImageElement * imgElement = (VTDOMImageElement *) element;
        
        if(![imgElement isLoading] && ![imgElement isLoaded]){
            [self.context handle:@protocol(IVTLocalImageTask) task:imgElement priority:0.0];
        }
    }
    
    for(VTDOMElement * el in [element childs]){
        [self loadImagesForElement:el];
    }
}

-(void) downloadImagesForElement:(VTDOMElement *) element{
    
    if([element isKindOfClass:[VTDOMImageElement class]]){
        
        VTDOMImageElement * imgElement = (VTDOMImageElement *) element;
        
        if(![imgElement isLoading] && ![imgElement isLoaded]){
            [imgElement setSource:self];
            [self.context handle:@protocol(IVTImageTask) task:imgElement priority:0];
        }
        
    }
    
    for(VTDOMElement * el in [element childs]){
        [self downloadImagesForElement:el];
    }
    
}


-(NSString *) htmlContentByIndexPath:(NSIndexPath *) indexPath{
    
    self.dataItem = [self dataObjectByIndexPath:indexPath];
    
    NSBundle * bundle = self.bundle;
    
    if(bundle == nil){
        bundle = [NSBundle mainBundle];
    }
    
    NSString * htmlContent = [NSString stringWithContentsOfFile:[[bundle bundlePath] stringByAppendingPathComponent:self.html] encoding:NSUTF8StringEncoding error:nil];
    
    htmlContent = [htmlContent htmlStringByDOMSource:self];
    
    return htmlContent;
    
}

-(void) document:(VTDOMDocument *) document didLoadedDataObject:(id) dataObject{
    
}

-(void) document:(VTDOMDocument *) document willLoadDataObject:(id) dataObject{
    
}

-(void) vtDOMView:(VTDOMView *) view doActionElement:(VTDOMElement *) element{
    if([self.delegate respondsToSelector:@selector(containerDataController:doActionElement:)]){
        [self.delegate containerDataController:self doActionElement:element];
    }
}

-(void) vtDOMView:(VTDOMView *)view downloadImagesForElement:(VTDOMElement *)element{
    [self downloadImagesForElement:element];
}

-(void) vtDOMView:(VTDOMView *)view downloadImagesForView:(UIView *) forView{
    [self downloadImagesForView:forView];
}

-(void) reloadData{
    [self.containerView setContainerLayout:_containerLayout];
    [super reloadData];
}

@end
