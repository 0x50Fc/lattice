//
//  LAHomeDataSource.m
//  Lattice
//
//  Created by ioshack on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHomeDataSource.h"
#import "LADBLatticeObject.h"

@implementation LAHomeDataSource
@synthesize historyLattices = _historyLattices;

- (void)loadResultsData:(id)resultsData
{
    [super loadResultsData:resultsData];
    
    if (!self.historyLattices) {
        self.historyLattices = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    [self.historyLattices removeAllObjects];
    
    VTDBContext * dbContext = [(id<LAContext>)self.context appDBContext];
    
    id<IVTSqliteCursor> curosr = [dbContext query:[LADBLatticeObject tableClass] sql:@" ORDER BY [timestamp] DESC" data:nil];
    
    while([curosr next]){
        
        LADBLatticeObject * dataObject = [[LADBLatticeObject alloc] init];
        [curosr toDataObject:dataObject];
        [self.historyLattices addObject:dataObject];
        
    }
    
    [curosr close];
}

@end
