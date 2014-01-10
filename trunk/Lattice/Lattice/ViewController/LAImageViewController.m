//
//  LAImageViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAImageViewController.h"

@interface LAImageViewController ()

@end

@implementation LAImageViewController

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
    
    NSDictionary * queryValues = [self.url queryValues];
    
    [_imageView setSrc:[queryValues valueForKey:@"url"]];
    [_imageView setSource:self];
    
    [self.context handle:@protocol(IVTImageTask) task:_imageView priority:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

-(void) delayCloseAction{
    
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait){
    
        [self openUrl:[NSURL URLWithString:@"." relativeToURL:self.url] animated:YES];
    
    }
}

- (IBAction)doTapAction:(id)sender {
    
    [self performSelector:@selector(delayCloseAction) withObject:nil afterDelay:0.3];
    
}

- (IBAction)doTap2Action:(id)sender {

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayCloseAction) object:nil];
    
    if(_contentView.zoomScale == 1.0){
        [_contentView setZoomScale:2.0 animated:YES];
    }
    else{
        [_contentView setZoomScale:1.0 animated:YES];
    }
    
}

- (IBAction)doSaveAction:(id)sender {
    
    if(_imageView.image == nil){
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片未下载完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
        
    }
    else{
        
        UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"成功保存到相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
        
    }
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

@end
