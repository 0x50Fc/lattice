//
//  LAHTMLViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"

@interface LAHTMLViewController : LAViewController<VTURLDocumentControllerDelegate>

@property(nonatomic,strong) IBOutlet VTStatusView * statusView;
@property (strong, nonatomic) IBOutlet VTURLDocumentController *documentController;

@end
