//
//  LABrowserViewController.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LABrowserViewController.h"

@interface LABrowserViewController ()

@end

@implementation LABrowserViewController

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
    
    NSURL * url = [NSURL URLWithString:[queryValues valueForKey:@"url"]];
    
    self.title = [queryValues valueForKey:@"title"];
    
    if(self.title == nil){
        self.navigationItem.title = @"加载中...";
    }

    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    if(self.title == nil){
        self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    [_statusView setStatus:nil];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [_statusView setStatus:@"error"];
    
}

@end
