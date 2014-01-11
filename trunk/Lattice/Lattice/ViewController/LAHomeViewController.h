//
//  LAHomeViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAViewController.h"
#import "LAHomeDataController.h"

#import "LAContainerDataController.h"

@interface LAHomeViewController : LAViewController<VTURLDocumentControllerDelegate>

@property (strong, nonatomic) IBOutlet LAContainerDataController *dataController;

@property (strong, nonatomic) IBOutlet VTURLDocumentController *documentController;

@end
