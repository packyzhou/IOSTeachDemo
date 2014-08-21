//
//  PKUIScrollViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-19.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIScrollViewController.h"

@interface PKUIScrollViewController ()
{
    UIScrollView *scrollView;
    UIImageView *imageView;
}
@end

@implementation PKUIScrollViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(setContentTodo)];
    [self initScrollView];
    // Do any additional setup after loading the view from its nib.
}

-(void) setContentTodo
{
//    scrollView.contentOffset = CGPointMake(250, 250);//设置可视原始坐标（即左上角的原始坐标）
//    UIEdgeInsets edgeInset = {250,250,0,0};
//    scrollView.scrollIndicatorInsets = edgeInset;//设置滚动条的位置
    [scrollView setContentOffset:CGPointMake(0,200) animated:YES];//设置滚动条位置
}

-(void) initScrollView
{
    UIImage *image = [UIImage imageNamed:@"CuriousFrog"];
    imageView = [[UIImageView alloc] initWithImage:image];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.delegate = self;//设置代理
    scrollView.contentSize = image.size;//设置滚动范围
    scrollView.maximumZoomScale = 2.0;//允许放大两倍
    scrollView.minimumZoomScale = 0.1;//允许缩小10倍
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;//设置滚动条的样式
    
//    UIEdgeInsets edgeInset = {50,50,0,0};
//    scrollView.contentInset = edgeInset; //设置上下左右边框距离
//    scrollView.bounces = NO;//设置滚动视图到达边缘时是否反弹效果
//    scrollView.bouncesZoom = NO;//设置缩放到极限值时是否有反弹效果
//    scrollView.directionalLockEnabled = YES;//锁定横向滚动时不能竖向滚动
//    scrollView.alwaysBounceHorizontal = YES;//设置水平方向滚动到达边界是否反弹
//    scrollView.alwaysBounceVertical = NO;//设置垂直方向滚动到达边界是否反弹
//    scrollView.decelerationRate = 10;//设置滚动条减速点
    
    [scrollView addSubview:imageView];//添加子视图
    [self.view addSubview:scrollView];
}

//缩放视图时需要指定缩放视图
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
