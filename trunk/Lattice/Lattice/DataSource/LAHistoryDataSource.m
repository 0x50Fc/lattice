//
//  LAHistoryDataSource.m
//  Lattice
//
//  Created by zhang hailong on 14-1-11.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LAHistoryDataSource.h"

#import "LADBLatticeObject.h"

@implementation LAHistoryDataSource

-(id) init{
    if((self = [super init])){
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dbChangedAction:) name:LALatticeObjectChangedNotification object:nil];
    }
    return self;
}

-(void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LALatticeObjectChangedNotification object:nil];
    
}

-(void) loadDataObjects{
    
    [self.dataObjects removeAllObjects];
    
    VTDBContext * dbContext = [(id<LAContext>)self.context appDBContext];
    
    id<IVTSqliteCursor> curosr = [dbContext query:[LADBLatticeObject tableClass] sql:@" ORDER BY [timestamp] DESC" data:nil];
    
    while([curosr next]){
        
        LADBLatticeObject * dataObject = [[LADBLatticeObject alloc] init];
        [curosr toDataObject:dataObject];
        
        NSMutableDictionary * dataItem = [NSMutableDictionary dictionaryWithCapacity:2];
        
        [dataItem setObject:dataObject forKey:@"dataObject"];
        
        [self.dataObjects addObject:dataItem];
        
    }
    
    [curosr close];

    
}

-(void) dbChangedAction:(NSNotification *) notification{
    
    [self loadDataObjects];
    
    if([self.delegate respondsToSelector:@selector(vtDataSourceDidContentChanged:)]){
        
        [self.delegate vtDataSourceDidContentChanged:self];
    }
}

-(void) reloadData{
    
    [super reloadData];
    
    [self loadDataObjects];
    
    if([self.delegate respondsToSelector:@selector(vtDataSourceDidLoaded:)]){
        [self.delegate vtDataSourceDidLoaded:self];
    }
}

@end
