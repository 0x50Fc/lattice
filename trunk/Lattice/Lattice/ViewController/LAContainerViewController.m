//
//  LAContainerViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAContainerViewController.h"

@interface LAContainerViewController ()

@property(nonatomic,retain) LAContainerDataController * dataController;
@property(nonatomic,assign,getter = isHtmlLoaded) BOOL htmlLoaded;
@property(nonatomic,retain) NSURL * htmlURL;

@end

@implementation LAContainerViewController

@synthesize dataController = _dataController;
@synthesize htmlLoaded = _htmlLoaded;
@synthesize htmlURL = _htmlURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LADBLatticeObject * dataObject = [self dataObject];
    
    NSString * containerType = [dataObject.infoObject stringValueForKey:@"containerType"];
    
    if([containerType isEqualToString:@"falls"]){
        
        self.dataController = self.fallsController;
    }
    else if([containerType isEqualToString:@"board"]){
        
        self.dataController = self.boardController;
    }
    else {
        self.dataController = self.listController;
    }
    
    [_containerView setDelegate:self.dataController];
    
    NSURL * baseURL = [NSURL URLWithString:dataObject.url];
    
    NSURL * url = [NSURL URLWithString:[dataObject.infoObject stringValueForKey:@"html"] relativeToURL:baseURL];
    
    NSLog(@"%@",[url absoluteString]);

    self.htmlURL = url;
    
    NSString * filePath = [self documentFilePath];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]){
        
        [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    self.dataController.infoObject = dataObject.infoObject;
    self.dataController.bundle = [NSBundle bundleWithPath:[filePath stringByDeletingLastPathComponent]];
    self.dataController.html = [dataObject.infoObject stringValueForKey:@"html"];
    self.dataController.documentURL = url;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil]){
        
        self.htmlLoaded = YES;

    }
    else{
        
        [_statusView setStatus:@"loading"];
        
        VTHttpTask * httpTask = [[VTHttpTask alloc] initWithSource:self];
        
        [httpTask setResponseType:VTHttpTaskResponseTypeResource];
        [httpTask setRequest:[NSURLRequest requestWithURL:url]];
        [httpTask setDelegate:self];
        
        [self.context handle:@protocol(IVTHttpResourceTask) task:httpTask priority:0];
        
    }
 
    [self.dataController.dataSource setValue:[dataObject.infoObject stringValueForKey:@"dataUrl"] forKey:@"url"];
    [self.dataController.dataSource setValue:[dataObject.infoObject stringValueForKey:@"dataKey"] forKey:@"dataKey"];
    
}

-(NSString *) documentFilePath{
    
    NSString * filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/htmls/%@%@",[_htmlURL host],[_htmlURL path]];
    
    if([filePath hasSuffix:@"/"]){
        filePath = [filePath stringByAppendingPathComponent:@"index.html"];
    }
    
    if([_htmlURL.query length]){
        
        filePath = [filePath stringByAppendingPathExtension:[_htmlURL.query vtMD5String]];
        
    }
    
    return filePath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([self isHtmlLoaded] && ![self.dataController.dataSource isLoaded]
       && ![self.dataController.dataSource isLoading]){
        
        [self.dataController reloadData];
    }
}


-(void) vtHttpTask:(id) httpTask didFailError:(NSError *) error{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[error LAMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    
    [_statusView setStatus:@"error"];
}

-(void) vtHttpTaskDidLoaded:(id) httpTask{
    
    NSString * filePath = [self documentFilePath];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * dir = [filePath stringByDeletingLastPathComponent];
    
    if(![fileManager fileExistsAtPath:dir]){
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [fileManager removeItemAtPath:filePath error:nil];
    
    [fileManager moveItemAtPath:[httpTask responseBody] toPath:filePath error:nil];
    
    self.htmlLoaded = YES;
    
    [self.dataController reloadData];
}

-(void) vtDataControllerWillLoading:(VTDataController *) controller{
    
}

-(void) vtDataControllerDidLoadedFromCache:(VTDataController *) controller timestamp:(NSDate *) timestamp{
    
    [_statusView setStatus:nil];
}

-(void) vtDataControllerDidLoaded:(VTDataController *) controller{
    [_statusView setStatus:nil];
}

-(void) vtDataController:(VTDataController *) controller didFitalError:(NSError *) error{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[error LAMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    
    [_statusView setStatus:@"error"];
}

-(void) vtDataControllerDidContentChanged:(VTDataController *) controller{
    
}


-(void) containerDataController:(LAContainerDataController *) dataController doActionElement:(VTDOMElement *) element{
    
    [self doElementAction:element];
    
}

@end
