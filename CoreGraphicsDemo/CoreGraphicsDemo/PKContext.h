//
//  PKContext.h
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-24.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKContext : NSObject
//动态切割大型图片
+(BOOL) cutImageForSavePath:(NSString *)imageName cutSize:(CGSize) size path:(NSString *)homePath;
@end
