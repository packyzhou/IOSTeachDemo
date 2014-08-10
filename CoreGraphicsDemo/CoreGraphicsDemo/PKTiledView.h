//
//  PKTiledView.h
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-24.
//  Copyright (c) 2014年 packy. All rights reserved.
//
//动态拼接图片类
#import <UIKit/UIKit.h>

typedef enum {
    notDo,next,org
} NextPosit;

@interface PKTiledView : UIView
@property NextPosit nextPosit;
@property NSString *imageName;
@property NSString *path;
@end
