//
//  PKPoolController.h
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPoolControllerDelegate.h"
@interface PKPoolController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *controllerArrays;//所有控制器
    UIScrollView *scrollView;//滚动条
    UISwipeGestureRecognizer *swipeGestureRecognizer;//手势控制
}

@property id<PKPoolControllerDelegate> delegate;//委托回调
@property UIViewController *controller;//获得当前controller
//初始化
-(id) initWithController:(NSMutableArray *)controllers;
-(void) setRecognizer:(BOOL) status;
-(void) displayControllers;

@end
