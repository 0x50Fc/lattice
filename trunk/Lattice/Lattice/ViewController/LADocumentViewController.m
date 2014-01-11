//
//  LADocumentViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LADocumentViewController.h"

@interface LADocumentViewController ()

@property(nonatomic,assign,getter = isHtmlLoaded) BOOL htmlLoaded;
@property(nonatomic,retain) NSURL * htmlURL;

@end

@implementation LADocumentViewController

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
    
    NSURL * baseURL = [NSURL URLWithString:dataObject.url];
    
    NSURL * url = [NSURL URLWithString:[dataObject.infoObject stringValueForKey:@"html"] relativeToURL:baseURL];
    
    NSLog(@"%@",[url absoluteString]);
    
    self.htmlURL = url;
    
    NSString * filePath = [self documentFilePath];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]){
        
        [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    _documentController.bundle = [NSBundle bundleWithPath:[filePath stringByDeletingLastPathComponent]];
    _documentController.html = [dataObject.infoObject stringValueForKey:@"html"];
    
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
    
    NSString * dataUrl = [dataObject.infoObject stringValueForKey:@"dataUrl"];
    
    dataUrl = [dataUrl htmlStringByDOMSource:[[NSURL URLWithString:dataObject.url] queryValues] htmlEncoded:NO];
    
    [_dataSource setValue:dataUrl forKey:@"url"];
    [_dataSource setValue:[dataObject.infoObject stringValueForKey:@"dataKey"] forKey:@"dataKey"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([self isHtmlLoaded] && ![self.dataSource isLoaded]
       && ![self.dataSource isLoading]){
        
        [self.dataSource reloadData];
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
    
    [self.dataSource reloadData];
}

-(void) loadDocument{
    
    _documentController.dataItem = [self.dataSource dataObject];
    
    [_documentController reloadData];
}

-(void) vtDataSourceDidLoadedFromCache:(VTDataSource *)dataSource timestamp:(NSDate *)timestamp{
    
    [_statusView setStatus:nil];
    
    [self loadDocument];
    
}

-(void) vtDataSourceDidLoaded:(VTDataSource *)dataSource{
    
    [_statusView setStatus:nil];
    
    [self loadDocument];
    
}

-(void) vtDataSource:(VTDataSource *)dataSource didFitalError:(NSError *)error{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[error LAMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    
    [_statusView setStatus:@"error"];
}

-(void) vtDocumentController:(VTDocumentController *) controller doActionElement:(VTDOMElement *) element{
    
    [self doElementAction:element];
    
}

@end
