//
//  PKUIDatePickerViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIDatePickerViewController.h"

@interface PKUIDatePickerViewController ()
{
    UIDatePicker *datePicker ;
}
@end

@implementation PKUIDatePickerViewController

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
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64, 320, 300)];
    datePicker.datePickerMode = UIDatePickerModeTime;//选择模式
    [datePicker setDate: [NSDate date] animated:YES];//设置当前时间
//    [datePicker setMinimumDate:[NSDate date]];//设置最小时间
    [datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*31]];//设置最大时间
    [datePicker setMinuteInterval:0.1];//设置分钟的间隔时间
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//设置时区
    
   
    [datePicker addTarget:self action:@selector(dateIsChange:) forControlEvents:UIControlEventValueChanged];//设置回调事件
    [self.view addSubview:datePicker];
    // Do any additional setup after loading the view from its nib.
}

-(void) dateIsChange:(UIDatePicker *) datePicker
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init]; // 定义时间格式
    [form setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateStr = [form stringFromDate:datePicker.date];
    NSLog(@"时间改变了:%@",dateStr);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
