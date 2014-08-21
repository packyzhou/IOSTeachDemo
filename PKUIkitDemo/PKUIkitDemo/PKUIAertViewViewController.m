//
//  PKUIAertViewViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIAertViewViewController.h"

@interface PKUIAertViewViewController ()
{
    UIAlertView *alertView;
}
@end

@implementation PKUIAertViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    alertView = [[UIAlertView alloc] initWithTitle:@"⚠警告" message:@"是否打开？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
//    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alertView show];
    // Do any additional setup after loading the view from its nib.
}

//控件被点击时调用
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"信息为：%@,%@",[alertView textFieldAtIndex:0],[alertView textFieldAtIndex:1]);
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
