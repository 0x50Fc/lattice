//
//  LAHomeViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHomeViewController.h"

@interface LAHomeViewController ()

@end

@implementation LAHomeViewController

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
    
   
    [_dataController reloadData];
    
    [_documentController setDocumentURL:[NSURL URLWithString:[self.config valueForKey:@"url"]]];
    
    [_documentController reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
 
}

-(void) containerDataController:(LAContainerDataController *) dataController doActionElement:(VTDOMElement *) element{
    
    [self doElementAction:element];
    
}

-(void) vtURLDocumentController:(VTURLDocumentController *) controller doActionElement:(VTDOMElement *) element{
    
    [self doElementAction:element];
    
}

-(void) vtURLDocumentControllerDidLoaded:(VTURLDocumentController *) controller{
    
    [controller.documentView setAllowAutoLayout:NO];
    
    CGRect frame = [controller.documentView.element frame];
    
    [_itemViewController setItemSize:frame.size];
    
    [_dataController.containerView reloadData];
    
}

@end
