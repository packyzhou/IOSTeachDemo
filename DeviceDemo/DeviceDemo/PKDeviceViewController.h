//
//  PKDeviceViewController.h
//  DeviceDemo
//
//  Created by 周经伟 on 14-8-12.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@interface PKDeviceViewController : UIViewController
@property(strong,nonatomic) IBOutlet UIProgressView *xProgressView;
@property(strong,nonatomic) IBOutlet UIProgressView *yProgressView;
@property(strong,nonatomic) IBOutlet UIProgressView *zProgressView;

@property(strong,nonatomic) IBOutlet UILabel *xLable;
@property(strong,nonatomic) IBOutlet UILabel *yLable;
@property(strong,nonatomic) IBOutlet UILabel *zLable;

@end
