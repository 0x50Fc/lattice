//
//  NSError+LA.m
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import "NSError+LA.h"

@implementation NSError (LA)

-(NSString *) LAMessage{
    return [self.userInfo valueForKey:NSLocalizedDescriptionKey];
}

@end
