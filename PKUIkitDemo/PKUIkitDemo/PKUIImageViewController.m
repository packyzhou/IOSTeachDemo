//
//  PKUIImageViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIImageViewController.h"

@interface PKUIImageViewController ()
{
    UIImageView *imageView ;
    NSArray *imageArray;
}
@end

@implementation PKUIImageViewController

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
    
    //获取图片缓存
    UIImage *image1 = [UIImage imageNamed:@"cat1.jpg"];
    //获取图片数据
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"cat2" ofType:@"jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image2 = [UIImage imageWithData:imageData];
    //获取程序图片路径
    NSString *imageFile = [[NSBundle mainBundle]pathForResource:@"cat3" ofType:@"jpeg"];
    UIImage *image3 = [UIImage imageWithContentsOfFile:imageFile];
    //从URL获取图片
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201302/27/20130227121432_tEdJT.jpeg"]];
    UIImage *image4 = [UIImage imageWithData:imageData2];
    
//    imageArray = @[image1,image2,image3,image4];//设置图片数组
//    imageView = [[UIImageView alloc] init];
//    imageView.frame = self.view.frame;
//    imageView.animationImages = imageArray;//设置动画图片
//    imageView.animationDuration = 10;//设置动画时间
//    imageView.animationRepeatCount = 0;//设置循环次数，0代表无限次
 
    imageView = [[UIImageView alloc] initWithImage:image1 highlightedImage:image2];
    
    UIButton *touchButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 50)];
    [touchButton setTitle:@"高亮图片" forState:UIControlStateNormal];
    touchButton.titleLabel.textColor = [UIColor blueColor];
    [touchButton addTarget:self action:@selector(touchImageTodo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchButton];
    [self.view addSubview:imageView];
//    [imageView startAnimating];
    // Do any additional setup after loading the view from its nib.
}

-(void) touchImageTodo
{
    imageView.highlighted = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
