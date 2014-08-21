//
//  PKUITextFieldViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-21.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUITextFieldViewController.h"

@interface PKUITextFieldViewController ()
{
    UITextField *textField;
}
@end

@implementation PKUITextFieldViewController

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
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10,100 , 200, 30)];
    textField.text = @"";//输入框文字
    textField.delegate = self;//设置代理
    textField.borderStyle = UITextBorderStyleRoundedRect;//边框样式
//    textField.disabledBackground = [UIImage imageNamed:@"progressbg.png"];//搞不懂

//    textField.background = [UIImage imageNamed:@"progressfg.png"];//背景图片
//    textField.backgroundColor = [UIColor blackColor];//背景颜色
    textField.textColor = [UIColor redColor];//字体颜色
    textField.placeholder = @"请输入文字……";//设置输入提示，输入时会隐藏
    textField.font = [UIFont fontWithName:@"Helvetica" size:20.0f];//字体样式和字体大小
    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;//设置输入清理按钮
//     textField.secureTextEntry = YES;//安全输入，密码时用到，输入内容变星
    //设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
    textField.adjustsFontSizeToFitWidth = YES;
    //设置左边边按钮View,会覆盖clearButtonMode
    textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more" ]];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.adjustsFontSizeToFitWidth = YES;//字体大小随输入框改变
    
    [self.view addSubview:textField];
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];//放弃第一响应对象
    
    return YES;
}
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
