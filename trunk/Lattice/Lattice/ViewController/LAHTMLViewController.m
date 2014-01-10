//
//  LAHTMLViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHTMLViewController.h"

#import "LADBLatticeObject.h"

@interface LAHTMLViewController ()

@end

@implementation LAHTMLViewController

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
    // Do any additional setup after loading the view from its nib.
    
    LADBLatticeObject * dataObject = [self.context focusValueForKey:@"latticeObject"];
    
    self.title = dataObject.title;
    
    NSString * tintColor = [dataObject.infoObject stringValueForKey:@"tintColor"];
    
    if(tintColor){
        
        int r=0,g=0,b=0;
        float a = 1.0;
        
        sscanf([tintColor UTF8String], "#%02x%02x%02x %f",&r,&g,&b,&a);
        
        self.view.tintColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
        
    }
    
    NSURL * baseURL = [NSURL URLWithString:dataObject.url];
    
    NSURL * url = [NSURL URLWithString:[dataObject.infoObject stringValueForKey:@"html"] relativeToURL:baseURL];
    
    NSLog(@"%@",[url absoluteString]);
    
    [_documentController setDocumentURL:url];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([_documentController document] == nil){
        
        [_statusView setStatus:@"loading"];
        
        [_documentController reloadData];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void) vtURLDocumentControllerWillLoading:(VTURLDocumentController *)controller{
 
}

-(void) vtURLDocumentControllerDidLoaded:(VTURLDocumentController *)controller{
    
    [_statusView setStatus:nil];
}

-(void) vtURLDocumentController:(VTURLDocumentController *)controller didFailWithError:(NSError *)error{
    
    [_statusView setStatus:@"error"];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[error LAMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alertView show];
    
}



@end
