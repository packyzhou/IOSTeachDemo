//
//  PKUISliderViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-21.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUISliderViewController.h"

@interface PKUISliderViewController ()
{
    UISlider *slider;
    UISwitch *switchView;
}
@end

@implementation PKUISliderViewController

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
    [self initSlider];
    [self initSwitch];
    // Do any additional setup after loading the view from its nib.
}

-(void) initSlider
{
    slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    slider.minimumValue = 0;//最小值
    slider.maximumValue = 10;//最大值
    slider.value = 2;//当前值
    slider.maximumValueImage = [UIImage imageNamed:@"maxImage"];//设置左边最小值标记
    slider.minimumValueImage = [UIImage imageNamed:@"minImage"];//设置右边最大值标记
    
    //设置背景图片，最大值为滑动按钮右边图片，最小值为滑动按钮左边图片
    [slider setMaximumTrackImage:[UIImage imageNamed:@"backgroundStrip"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"backgroundStrip"] forState:UIControlStateNormal];
    //设置拖动按钮图片，必须设置highlighted
    [slider setThumbImage:[UIImage imageNamed:@"moveButton"] forState:UIControlStateHighlighted];
    [slider setThumbImage:[UIImage imageNamed:@"moveButton"] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];//增加事件监听
    [self.view addSubview:slider];
}

-(void) sliderChange:(UISlider *) sender
{
    NSLog(@"当前值为：%f",slider.value);
}

-(void) initSwitch
{
    switchView = [[UISwitch alloc]initWithFrame:CGRectMake(10, 200, 300, 30)];
    switchView.on = YES;//设置选择按钮状态
    switchView.thumbTintColor = [UIColor redColor];//设置滑动按钮颜色
    switchView.tintColor = [UIColor yellowColor];//未选择状态下的颜色
    switchView.onTintColor = [UIColor blueColor];//选择状态下的颜色
    [switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];//增加事件监听
    [self.view addSubview:switchView];
}

-(void) switchChange:(UISwitch *) sender
{
    BOOL switchStatus = sender.isOn;//是否被选择
    if (switchStatus) {
        NSLog(@"被选择了");
    }else{
        NSLog(@"未被选择");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
