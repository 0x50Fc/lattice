//
//  LAContainerDataController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>

@interface LAContainerDataController : VTContainerDataController<VTDOMViewDelegate>

@property(nonatomic,retain) id dataItem;
@property(nonatomic,retain) NSBundle * bundle;
@property(nonatomic,retain) NSString * html;
@property(nonatomic,retain) VTDOMStyleSheet * styleSheet;
@property(nonatomic,retain) IBOutlet VTContainerLayout * containerLayout;
@property(nonatomic,retain) id infoObject;

-(void) document:(VTDOMDocument *) document didLoadedDataObject:(id) dataObject;

-(void) document:(VTDOMDocument *) document willLoadDataObject:(id) dataObject;

-(NSString *) htmlContentByIndexPath:(NSIndexPath *) indexPath;

-(void) downloadImagesForElement:(VTDOMElement *) element;

-(void) loadImagesForElement:(VTDOMElement *) element;

-(VTDOMDocument *) documentByIndexPath:(NSIndexPath *) indexPath layoutSize:(CGSize) layoutSize;

@end


@protocol LAContainerDataControllerDelegate <VTContainerDataControllerDelegate>

@optional

-(void) containerDataController:(LAContainerDataController *) dataController doActionElement:(VTDOMElement *) element;

@end