//
//  LALatticeService.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "LALatticeService.h"

#import "LALatticePullTask.h"

#import "LALatticeBeaconTask.h"

#import "LALatticeBeaconQueryTask.h"

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
    else if(@protocol(ILALatticeBeaconTask) == taskType){
        
        id<ILALatticeBeaconTask> latticeTask = (id<ILALatticeBeaconTask>) task;
        
        VTAPIRequestTask * httpTask = [[VTAPIRequestTask alloc] init];
        
        [httpTask setSource:[task source]];
        [httpTask setTask:task];
        [httpTask setTaskType:taskType];
        
        [httpTask setApiKey:@"api"];
        
        VTHttpFormBody * body = [[VTHttpFormBody alloc] init];
        
        [body addItemValue:@"LALatticeBeaconTask" forKey:@"taskType"];
        [body addItemValue:[latticeTask beaconKey] forKey:@"la-beaconKey"];
        [body addItemValue:[VTJSON encodeObject:[latticeTask infoObject]] forKey:@"la-infoObject"];
        
        [httpTask setBody:body];
        
        [self.context handle:@protocol(IVTAPIRequestTask) task:httpTask priority:0];
        
        return YES;
    }
    else if(@protocol(ILALatticeBeaconQueryTask) == taskType){
        
        id<ILALatticeBeaconQueryTask> latticeTask = (id<ILALatticeBeaconQueryTask>) task;
        
        VTAPIRequestTask * httpTask = [[VTAPIRequestTask alloc] init];
        
        [httpTask setSource:[task source]];
        [httpTask setTask:task];
        [httpTask setTaskType:taskType];
        
        [httpTask setApiKey:@"api"];
        
        VTHttpFormBody * body = [[VTHttpFormBody alloc] init];
        
        [body addItemValue:@"LALatticeBeaconQueryTask" forKey:@"taskType"];
        [body addItemValue:[[latticeTask beaconKeys] componentsJoinedByString:@","] forKey:@"la-beaconKeys"];
        
        [httpTask setBody:body];
        
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
        else if([respTask taskType] == @protocol(ILALatticeBeaconTask)){
            
            if([respTask error]){
                [self vtUplinkTask:[respTask task] didFailWithError:[respTask error] forTaskType:[respTask taskType]];
            }
            else{
                
                int errorCode = [[respTask resultsData] intValueForKey:@"error-code"];
                NSString * error = [[respTask resultsData] stringValueForKey:@"error" defaultValue:@""];
                
                if(errorCode){
                    
                    
                    [self vtUplinkTask:[respTask task] didFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:errorCode userInfo:[NSDictionary dictionaryWithObject:error forKey:NSLocalizedDescriptionKey]] forTaskType:[respTask taskType]];
                    
                }
                else{
                    
                    [self vtUplinkTask:[respTask task] didSuccessResults:[respTask resultsData] forTaskType:[respTask taskType]];
                }
                
            }
            
            return YES;
        }
        else if([respTask taskType] == @protocol(ILALatticeBeaconQueryTask)){
            
            if([respTask error]){
                [self vtUplinkTask:[respTask task] didFailWithError:[respTask error] forTaskType:[respTask taskType]];
            }
            else{
                
                int errorCode = [[respTask resultsData] intValueForKey:@"error-code"];
                NSString * error = [[respTask resultsData] stringValueForKey:@"error" defaultValue:@""];
                
                if(errorCode){
                    
                    [self vtUplinkTask:[respTask task] didFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:errorCode userInfo:[NSDictionary dictionaryWithObject:error forKey:NSLocalizedDescriptionKey]] forTaskType:[respTask taskType]];
                    
                }
                else{
                    
                    NSDictionary * infoObjects = [[respTask resultsData] dictionaryValueForKey:@"beacon-query-results"];
                    
                    id<ILALatticeBeaconQueryTask> latticeTask = (id<ILALatticeBeaconQueryTask>) [respTask task];
                    
                    [latticeTask setInfoObjects:infoObjects];
                    
                    [self vtUplinkTask:[respTask task] didSuccessResults:[respTask resultsData] forTaskType:[respTask taskType]];
                }
                
            }
            
            return YES;
        }
    }
    
    return NO;
}

@end
