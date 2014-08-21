//
//  PKUISegmentedViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-21.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUISegmentedViewController.h"

@interface PKUISegmentedViewController ()
{
    UISegmentedControl *segmentedControl;
    UIStepper *stepper;
    NSArray *dataArray;
}
@end

@implementation PKUISegmentedViewController

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
    [self initSegmentedControl];
    [self initStepper];
    // Do any additional setup after loading the view from its nib.
}

-(void) initSegmentedControl
{
    dataArray = @[@"按钮1",@"按钮2",@"按钮3",@"🔘"];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:dataArray];
    segmentedControl.frame = CGRectMake(10, 100, 300, 30);
//    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//设置样式，IOS7后被废
    [segmentedControl addTarget:self action:@selector(toolsChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void) toolsChange:(UISegmentedControl *) sender
{
    NSLog(@"选了：%i", sender.selectedSegmentIndex);
}

-(void) stepperChange:(UIStepper *) sender
{
    NSLog(@"值：%f",sender.value);//获取当前值
}

-(void) initStepper
{
    stepper = [[UIStepper alloc] initWithFrame:CGRectMake(10, 200, 300, 30)];
    stepper.minimumValue = 0;//设置最小值
    stepper.maximumValue = 100;//设置最大值
    stepper.stepValue = 2;//设置递增数
    stepper.tintColor = [UIColor redColor];//设置控件颜色
    stepper.autorepeat = NO;//设置按住是否连续递增，默认YES
    stepper.wraps = YES;//设置极限值时返回初始值
    stepper.continuous = YES ;//设置是否在释放按钮时才触发事件，默认YES
    [stepper addTarget:self action:@selector(stepperChange:) forControlEvents:UIControlEventValueChanged];//监听值的变化
//    [stepper setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal]; // 设置不同状态显示不的不同背景图片
    [self.view addSubview:stepper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
