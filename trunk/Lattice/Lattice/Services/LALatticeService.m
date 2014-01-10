//
//  LALatticeService.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LALatticeService.h"

#import "LALatticePullTask.h"

@implementation LALatticeService

-(BOOL) handle:(Protocol *)taskType task:(id<IVTTask>)task priority:(NSInteger)priority{
    
    if(@protocol(ILALatticePullTask) == taskType){
        
        id<ILALatticePullTask> latticeTask = (id<ILALatticePullTask>) task;
        
        VTDBContext * dbContext = [(id<LAContext>) self.context appDBContext];
        
        id<IVTSqliteCursor> cursor = [dbContext query:[LADBLatticeObject tableClass] sql:@"WHERE url=:url" data:latticeTask];
        
        if([cursor next]){
            
            LADBLatticeObject * dataObject = [[LADBLatticeObject alloc] init];
            
            [cursor toDataObject:dataObject];
            
            [latticeTask setDataObject:dataObject];
            [latticeTask setVersion:dataObject.version];
            
        }

        [cursor close];
        
        VTAPIRequestTask * httpTask = [[VTAPIRequestTask alloc] init];
        
        [httpTask setSource:[task source]];
        [httpTask setTask:task];
        [httpTask setTaskType:taskType];
        
        [httpTask setApiUrl:[latticeTask url]];
        
        [self.context handle:@protocol(IVTAPIRequestTask) task:httpTask priority:0];
        
        return YES;
    }
    else if(@protocol(IVTAPIResponseTask) == taskType){
        
        id<IVTAPIResponseTask> respTask = (id<IVTAPIResponseTask>) task;
        
        
        if([respTask taskType] == @protocol(ILALatticePullTask)){
            
            if([respTask error]){
                
                [self vtUplinkTask:[respTask task] didFailWithError:[respTask error] forTaskType:[respTask taskType]];
                
            }
            else{
                
                id<ILALatticePullTask> latticeTask = (id<ILALatticePullTask>) [respTask task];
                
                id resultsData = [respTask resultsData];
                
                NSLog(@"%@",resultsData);
                
                if([resultsData isKindOfClass:[NSDictionary class]]){
                    
                    NSString * version = [resultsData stringValueForKey:@"version"];
                    
                    if(version){
                        
                        VTDBContext * dbContext = [(id<LAContext>) self.context appDBContext];
                        
                        LADBLatticeObject * dataObject = [latticeTask dataObject];
                        
                        if(dataObject == nil){
                            dataObject = [[LADBLatticeObject alloc] init];
                            dataObject.url = [latticeTask url];
                            [latticeTask setDataObject:dataObject];
                        }
                        
                        dataObject.title = [resultsData stringValueForKey:@"title"];
                        dataObject.image = [resultsData stringValueForKey:@"image"];
                        dataObject.uri = [resultsData stringValueForKey:@"uri"];
                        dataObject.infoObject = resultsData;
                        dataObject.version = version;
                        dataObject.timestamp = [[NSDate date] timeIntervalSince1970];
                        
                        if(dataObject.rowid){
                            [dbContext updateObject:dataObject];
                        }
                        else{
                            [dbContext insertObject:dataObject];
                        }
                        
                        [self vtUplinkTask:latticeTask didSuccessResults:resultsData forTaskType:[respTask taskType]];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:LALatticeObjectChangedNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:dataObject,LALatticeObjectKey,[latticeTask version],@"version", nil]];
                    }
                    else{
                        [self vtUplinkTask:[respTask task] didFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:[NSDictionary dictionaryWithObject:@"资源描述错误" forKey:NSLocalizedDescriptionKey]] forTaskType:[respTask taskType]];
                    }
                }
                else{
                    [self vtUplinkTask:[respTask task] didFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:[NSDictionary dictionaryWithObject:@"资源描述错误" forKey:NSLocalizedDescriptionKey]] forTaskType:[respTask taskType]];
                }
            }
            
            return YES;
        }
        
    }
    
    return NO;
}

@end
