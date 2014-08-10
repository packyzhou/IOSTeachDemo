//
//  PKSocketViewController.h
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-4.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKSocketViewController : UIViewController<NSStreamDelegate>
@property(strong,nonatomic) IBOutlet UITextField *nameText;
@property(strong,nonatomic) IBOutlet UITextField *msgText;
@property(strong,nonatomic) IBOutlet UIButton *sendButton;
@property(strong,nonatomic) IBOutlet UITextView *textView;
@end
