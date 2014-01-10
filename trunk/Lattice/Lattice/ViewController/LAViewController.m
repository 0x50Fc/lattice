/**
 *  LAViewController.m
 *  Lattice
 *
 *  Created by zhang hailong on 14-1-10.
 *  Copyright 9vteam 2014年. All rights reserved.
 */


#import "LAViewController.h"

#import "LALatticePullTask.h"

@interface LAViewController ()

@end

@implementation LAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) openLatticeUrl:(NSString *) url{
    
    LALatticePullTask * task = [[LALatticePullTask alloc] init];
    
    [task setUrl:url];
    
    [self.context handle:@protocol(ILALatticePullTask) task:task priority:0];
    
    if([task dataObject]){
        
        [self openLatticeObject:[task dataObject]];
        
    }
    else{
        
        [task setSource:self];
        [task setDelegate:self];
        
        [_latticeLoadingView setStatus:@"loading"];
    }
    
}

-(void) openLatticeObject:(LADBLatticeObject *) dataObject{
    
    NSString * uri = [dataObject uri];
    
    [self.context setFocusValue:dataObject forKey:@"latticeObject"];
    
    [self openUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.alias,uri] relativeToURL:self.url queryValues:dataObject] animated:YES];
    
}

-(void) vtUploadTask:(id<IVTUplinkTask>)uplinkTask didFailWithError:(NSError *)error forTaskType:(Protocol *)taskType{
    
    if(taskType == @protocol(ILALatticePullTask)){
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[error LAMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
        
    }
    
}


-(void) vtUploadTask:(id<IVTUplinkTask>)uplinkTask didSuccessResults:(id)results forTaskType:(Protocol *)taskType{

    if(taskType == @protocol(ILALatticePullTask)){
        
        [_latticeLoadingView setStatus:nil];
        
        id<ILALatticePullTask> latticeTask = (id<ILALatticePullTask>) uplinkTask;
        
        if([latticeTask dataObject]){
            
            [self openLatticeObject:[latticeTask dataObject]];
            
        }
        
    }
    
}

-(void) doElementAction:(VTDOMElement *) element{

    NSString * actionName = [element attributeValueForKey:@"action-name"];
    
    if([actionName isEqualToString:@"web"]){
        
        NSString * url = [element stringValueForKey:@"url"];
        NSString * title = [element stringValueForKey:@"title"];
        
        if(url){
            
            [self openUrl:[NSURL URLWithString:@"present://root/browser" relativeToURL:self.url queryValues:[NSDictionary dictionaryWithObjectsAndKeys:url,@"url",title,@"title", nil]] animated:YES];
            
        }
        
    }
    else if([actionName isEqualToString:@"image"]){
        
        NSString * url = [element stringValueForKey:@"url"];
        
        if(url){
            
            [self openUrl:[NSURL URLWithString:@"present://root/image" relativeToURL:self.url queryValues:[NSDictionary dictionaryWithObjectsAndKeys:url,@"url", nil]] animated:YES];
            
        }
        
    }
}

@end
