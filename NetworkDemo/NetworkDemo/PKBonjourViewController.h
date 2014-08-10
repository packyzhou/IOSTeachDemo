//
//  PKBonjourViewController.h
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-5.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKBonjourViewController : UIViewController<NSNetServiceBrowserDelegate,NSNetServiceDelegate>
@property(strong,nonatomic) IBOutlet UIButton *registServiceButton;
@property(strong,nonatomic) IBOutlet UIButton *findServiceButton;
@property(strong,nonatomic) IBOutlet UIButton *analysisServiceButton;
@end
