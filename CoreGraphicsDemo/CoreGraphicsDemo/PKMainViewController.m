//
//  PKMainViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKMainViewController.h"

@interface PKMainViewController ()
{
    PKTiledView *tiledView;
}
@end

@implementation PKMainViewController

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
    //设置颜色
    self.view.backgroundColor = [UIColor blackColor];
    
    //导航条
    self.navigationItem.title = @"主界面";
    
    //设置代理
    poolController = [[PKPoolController alloc] initWithController:[self loadControllers]];
    poolController.delegate = self;
    poolController.controller = self;
    
    [poolController setRecognizer:YES];//添加手势
    
    [poolController displayControllers];
    
   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"动画" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) rightButton:(id) sender
{
        
    PKAnimationViewController *animationController = [[PKAnimationViewController alloc] initWithNibName:@"PKAnimationViewController" bundle:nil];
    
    [self.navigationController pushViewController:animationController animated:YES];
}

//加载视图控制器
-(NSMutableArray *) loadControllers
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    PKRedViewController *redController = [[PKRedViewController alloc] initWithNibName:@"PKRedViewController" bundle:nil];
    [array addObject:redController];
    PKBlueViewController *blueController = [[PKBlueViewController alloc] initWithNibName:@"PKBlueViewController" bundle:nil];
    [array addObject:blueController];
    PKGreenViewController *greenController = [[PKGreenViewController alloc] initWithNibName:@"PKGreenViewController" bundle:nil];
    [array addObject:greenController];
    PKYellowViewController *yellowController = [[PKYellowViewController alloc] initWithNibName:@"PKYellowViewController" bundle:nil];
    [array addObject:yellowController];
    return array;
}

-(void) acquisitionIndexAndControllerToPool:(UIViewController *) controller ofIndex:(NSInteger) index offset:(CGFloat) offset
{

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width,44)];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-30, 0 , self.view.frame.size.width,44)];
   
    titleView.alpha = 0;
    
    [titleView addSubview:titleLable];
    
    [UIView beginAnimations:@"titleAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.5];
    titleView.alpha = 1;
    
    if (index == 0) {
        titleLable.text = @"红界面";
    }else if (index == 1) {
        titleLable.text  = @"蓝界面";
    }else if (index == 2) {
        titleLable.text  = @"绿界面";
    }else if (index == 3) {
        titleLable.text  = @"黄界面";
    }
    self.navigationItem.titleView = titleView;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
