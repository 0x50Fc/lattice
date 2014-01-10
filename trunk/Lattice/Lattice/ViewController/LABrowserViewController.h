//
//  LABrowserViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"

@interface LABrowserViewController : LAViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet VTStatusView *statusView;

@end
