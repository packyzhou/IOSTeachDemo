//
//  PKNetworkViewController.h
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-1.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"
#import "PKSocketViewController.h"
#import "PKBonjourViewController.h"
@interface PKNetworkViewController : UIViewController<NSURLConnectionDataDelegate,NSStreamDelegate,NSXMLParserDelegate>
@property(strong,nonatomic) IBOutlet UIButton *httpButton;
@property(strong,nonatomic) IBOutlet UIButton *tcpButton;
@property(strong,nonatomic) IBOutlet UIButton *udpButton;
@property(strong,nonatomic) IBOutlet UIButton *uploadButton;
@property(strong,nonatomic) IBOutlet UIButton *thirdPartButton;
@property(strong,nonatomic) IBOutlet UIButton *sendMsgButton;
@property(strong,nonatomic) IBOutlet UIButton *bonjourButton;
@property(strong,nonatomic) IBOutlet UIButton *checkNetworkButton;
@property(strong,nonatomic) IBOutlet UIButton *xmlRequestButton;
@end
