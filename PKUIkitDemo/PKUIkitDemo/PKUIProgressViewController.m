//
//  PKUIProgressViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-20.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIProgressViewController.h"

@interface PKUIProgressViewController ()
{
    UIProgressView *progressView ;
}
@end

@implementation PKUIProgressViewController

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
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
//    progressView.progressTintColor = [UIColor redColor];//进度条颜色
//    progressView.trackTintColor = [UIColor grayColor];//进度条未完成颜色
//    progressView.progressViewStyle = UIProgressViewStyleDefault;//设置样式
    [progressView setProgressImage: [UIImage imageNamed:@"progressfg.png"]];//设置进度条image
    [progressView setTrackImage: [UIImage imageNamed:@"progressbg.png"]];//设置未完成进度条image
    progressView.clipsToBounds = YES;//当内容出边界时剪掉
    [self.view addSubview:progressView];
    
    [_setProgressButton addTarget:self action:@selector(setSeventyfivePercent) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void) setSeventyfivePercent
{
    progressView.progress = 0.75;//设置百分比
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
