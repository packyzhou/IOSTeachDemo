//
//  PKDynameViewController.h
//  PhysicalEngineDemo
//
//  Created by 周经伟 on 14-8-12.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKObjectView.h"
@interface PKDynameViewController : UIViewController<UIDynamicAnimatorDelegate>
@property(strong,nonatomic) IBOutlet UIButton *gravityButton;
@property(strong,nonatomic) IBOutlet UIButton *collisionButton;
@property(strong,nonatomic) IBOutlet UIButton *snapButton;
@property(strong,nonatomic) IBOutlet UIButton *pushButton;
@property(strong,nonatomic) IBOutlet UIButton *attachmentButton;
@property(strong,nonatomic) IBOutlet UIButton *dynamicButton;
@property(strong,nonatomic) IBOutlet UIButton *resetButton;
@end
