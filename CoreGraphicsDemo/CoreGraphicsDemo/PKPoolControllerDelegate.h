//
//  PKPoolControllerDelegate.h
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PKPoolControllerDelegate <NSObject>
@optional
-(void) acquisitionIndexAndControllerToPool:(UIViewController *) controller ofIndex:(NSInteger) index offset:(CGFloat) offset;

@end
