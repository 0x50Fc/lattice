//
//  LAImageViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"

@interface LAImageViewController : LAViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet VTImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *contentView;

- (IBAction)doTapAction:(id)sender;
- (IBAction)doTap2Action:(id)sender;
- (IBAction)doSaveAction:(id)sender;

@end
