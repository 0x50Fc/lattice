//
//  LAWebViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAWebViewController.h"

@interface LAWebViewController ()

@end

@implementation LAWebViewController

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
    
    NSURL * baseURL = [NSURL URLWithString:self.dataObject.url];
    
    NSURL * url = [NSURL URLWithString:[self.dataObject.infoObject stringValueForKey:@"web"] relativeToURL:baseURL];
    
    NSLog(@"%@",[url absoluteString]);

    [_statusView setStatus:@"loading"];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    [_statusView setStatus:nil];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [_statusView setStatus:@"error"];
    
}

@end
