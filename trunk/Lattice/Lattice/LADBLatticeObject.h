//
//  LADBLatticeObject.h
//  Lattice
//
//  Created by zhang hailong on 14-1-10.
//  Copyright (c) 2014年 9vteam. All rights reserved.
//

#import <vTeam/vTeam.h>

@interface LADBLatticeObject : VTDBObject

// 标题
@property(nonatomic,retain) NSString * title;

// 图片
@property(nonatomic,retain) NSString * image;

// 内部URI
@property(nonatomic,retain) NSString * uri;

// 资源URL
@property(nonatomic,retain) NSString * url;

// 资源描述
@property(nonatomic,retain) id infoObject;

// 资源版本号
@property(nonatomic,retain) NSString * version;

// 设置选项
@property(nonatomic,retain) id settingObject;

@property(nonatomic,assign) NSTimeInterval timestamp;

@end
