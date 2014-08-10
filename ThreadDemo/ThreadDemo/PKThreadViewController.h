//
//  PKThreadViewController.h
//  ThreadDemo
//
//  Created by 周经伟 on 14-7-31.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
static int numbers = 10;
@interface PKThreadViewController : UIViewController
@property(strong,nonatomic) IBOutlet UIButton *threadButton;
@property(strong,nonatomic) IBOutlet UIButton *operationButton;
@property(strong,nonatomic) IBOutlet UIButton *gcdButton;
@property(strong,nonatomic) IBOutlet UIButton *threadRunloopButton;
@end
