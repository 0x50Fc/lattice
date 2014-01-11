//
//  LADocumentViewController.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LALatticeViewController.h"

#import "LAURLDataSource.h"

@interface LADocumentViewController : LALatticeViewController<IVTUplinkTaskDelegate,VTDataSourceDelegate,VTDocumentControllerDelegate>

@property (strong, nonatomic) IBOutlet VTStatusView * statusView;
@property (strong, nonatomic) IBOutlet VTDocumentController *documentController;
@property (strong, nonatomic) IBOutlet LAURLDataSource *dataSource;

@end
