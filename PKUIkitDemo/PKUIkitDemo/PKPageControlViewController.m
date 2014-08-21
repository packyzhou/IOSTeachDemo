//
//  PKPageControlViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-20.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKPageControlViewController.h"

@interface PKPageControlViewController ()
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSArray *dataArray;
    UISwipeGestureRecognizer *swipeGestureRecognizer;
}
@end

@implementation PKPageControlViewController

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
    [self initImages];
    [self initScrollView];
    [self initPageView];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view from its nib.
}

-(void) initImages
{
    UIImage *image1 = [UIImage imageNamed:@"cat1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"cat2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"cat3.jpeg"];
    UIImage *image4 = [UIImage imageNamed:@"cat4.jpeg"];
    dataArray = @[image1,image2,image3,image4];
}

-(void) initScrollView
{
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    CGSize scrollViewSize = CGSizeMake(dataArray.count * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    scrollView.contentSize = scrollViewSize;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;//设置滚动视图到达边缘时是否反弹效果
    
    int i = 0;
    for (UIImage *image in dataArray) {
        float imageScale = image.size.width/320;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(320*i, 0,  CGRectGetWidth(self.view.frame), image.size.height*imageScale);
        
       [scrollView addSubview:imageView];
        i++;
    }
    [self.view addSubview:scrollView];
}

-(void) initPageView
{
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 500, 320, 0)];
    pageControl.numberOfPages = [dataArray count];//设置页数
    pageControl.currentPage = 0;//设置当前页数
//    pageControl.hidesForSinglePage = YES ;//当页面只有一个的时候，隐藏
//    pageControl.userInteractionEnabled = YES;//允许用户交互
//    pageControl.enabled = YES;
//    pageControl.defersCurrentPageDisplay = YES; //手动更新页数
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];//监听当前页数
    
    //添加滑动手势
    swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x / bounds.size.width];
}

-(void) handleSwipes:(UISwipeGestureRecognizer *) sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        pageControl.currentPage = --pageControl.currentPage;
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        pageControl.currentPage = ++pageControl.currentPage;
    }
}

-(void) pageTurn:(UIPageControl *) sender
{
    NSInteger page = sender.currentPage;
    NSLog(@"当前页面：%i",page);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
