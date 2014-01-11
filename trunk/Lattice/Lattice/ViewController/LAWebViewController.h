//
//  LAWebViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LALatticeViewController.h"

@interface LAWebViewController : LALatticeViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet VTStatusView *statusView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
