//
//  PKUIActionSheetViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIActionSheetViewController.h"

@interface PKUIActionSheetViewController ()
{
    UIActionSheet *actionSheet;
}
@end

@implementation PKUIActionSheetViewController

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
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"⚠警告"
                                                             delegate:self
                                                    cancelButtonTitle:@"知道了" destructiveButtonTitle:@"别再打开了" otherButtonTitles:@"稍后提示", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.navigationController.view];
    // Do any additional setup after loading the view from its nib.
}
//点击时调用
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"点击了：%i",buttonIndex);
    
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"actionSheetCancel");
}
//将要显示时调用
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
     NSLog(@"willPresentActionSheet");
}
//显示时调用
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
     NSLog(@"didPresentActionSheet");
}
//将要销毁控件时调用
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
     NSLog(@"willDismissWithButtonIndex");
}
//销毁控件时调用
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"didDismissWithButtonIndex");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
