//
//  PKUITabBarViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUITabBarViewController.h"

@interface PKUITabBarViewController ()
{
    UITabBar *tabBar;
    NSArray *dataArray;
}
@end

@implementation PKUITabBarViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏" style:UIBarButtonItemStylePlain target:self action:@selector(hideTabBar)];
    
//    CGRect tabBarRect = CGRectMake(0, CGRectGetHeight(self.view.frame)-49, CGRectGetWidth(self.view.frame),98);
//    tabBar = [[UITabBar alloc] initWithFrame:tabBarRect];
//    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"main_page" ] tag:0];
//    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"运动状态" image:[UIImage imageNamed:@"sport_status" ] tag:1];
//    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"统计工具" image:[UIImage imageNamed:@"count_tool" ] tag:2];
//    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"篮球" image:[UIImage imageNamed:@"basketball" ] tag:3];
//    UITabBarItem *tabBarItem5 = [[UITabBarItem alloc] initWithTitle:@"冠军" image:[UIImage imageNamed:@"champion" ] tag:4];
//    UITabBarItem *tabBarItem6 = [[UITabBarItem alloc] initWithTitle:@"图标" image:[UIImage imageNamed:@"more" ] tag:5];
//    UITabBarItem *tabBarItem7 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:6];
//    
//    tabBarItem7.badgeValue = @"2";//右上角红色圆
//    dataArray = @[tabBarItem1,tabBarItem2,tabBarItem3,tabBarItem4,tabBarItem7];
//    [tabBar setItems:dataArray animated:YES];//设置bar数组
//    tabBar.delegate = self;
    
//    tabBar.barStyle = UIBarStyleBlackOpaque;
//    tabBar.barTintColor = [UIColor clearColor];//设置bar背景颜色
//    [self.view addSubview:tabBar];
    // Do any additional setup after loading the view from its nib.
}

-(void) initTabBarController
{
    
    UIViewController *controller1 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIView *view1 = [[UIView alloc] initWithFrame:self.view.frame];
    view1.backgroundColor = [UIColor redColor];
    [controller1 setView:view1];
    controller1.title = @"红色";
    controller1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    
    UIViewController *controller2 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIView *view2 = [[UIView alloc] initWithFrame:self.view.frame];
    view2.backgroundColor = [UIColor blueColor];
    [controller2 setView:view2];
    controller2.title = @"蓝色";
    controller2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    
    
    self.delegate = self;
    self.tabBarController.viewControllers = @[controller1,controller2];
}

-(void) hideTabBar
{
    NSLog(@"隐藏");
//    tabBar.hidden = YES;
    
}
//选择tab时调用
- (void)tabBar:(UITabBar *)tabbar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"Selected is %d",item.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
