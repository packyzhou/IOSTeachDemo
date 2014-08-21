//
//  PKUItextViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-19.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUITextViewController.h"

@interface PKUITextViewController ()
{
    UITextView *textView ;
}
@end

@implementation PKUITextViewController

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
    [self initTextView];
    // Do any additional setup after loading the view from its nib.
}

-(void) initTextView
{
    NSString *textStr = @"当然，因为这份报告涉及的初创企业仅是交通领域的，而所谓的企业好坏则是靠 AngelList 的 Signal 分数来评判的，但是这个分数究竟是怎么出来的还不好说，看起来似乎是公司质量与流行度的结合，但未必就是公司好坏的合理评判，而且使用技术与公司表现未必就有直接关系，所以说报告仅供参考。";
    textView = [[UITextView alloc] initWithFrame:self.view.frame];
    textView.text = textStr;//设置文本域内文字
    textView.backgroundColor=[UIColor blackColor]; //背景色
    textView.textColor = [UIColor whiteColor];//设置字体颜色
    textView.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textView.editable = YES;        //是否允许编辑内容，默认为“YES”
    textView.delegate = self;       //设置代理方法的实现类
    textView.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
    textView.returnKeyType = UIReturnKeyGoogle;//键盘return键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    
    textView.keyboardAppearance = UIKeyboardAppearanceAlert;//设置设置键盘风格
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置输入风格，比如全部为大写
    textView.autocorrectionType = UITextAutocorrectionTypeNo;//自动更正
    textView.secureTextEntry=YES;//文本输入安全，禁止自动修改和缓存信息
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    toolView.backgroundColor = [UIColor redColor];
    textView.inputAccessoryView = toolView;//设置键盘上的UIView
    [self.view addSubview:textView];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
