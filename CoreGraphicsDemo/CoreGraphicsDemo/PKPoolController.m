//
//  PKPoolController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKPoolController.h"

@implementation PKPoolController
@synthesize delegate = _delegate;

-(id) initWithController:(NSMutableArray *)controllers
{
    if(self = [super init])
    {
        controllerArrays = controllers;
    }
    return self;
}

-(void) displayControllers
{
    [self setScrollView];
    [self setPoolWithControllers];
}

//设置滚动条
-(void) setScrollView
{
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.controller.view.bounds];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.controller.view.frame) * [self controllersCount], 0);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
 
    
    [self.controller.view addSubview:scrollView];
    
}

-(NSInteger) controllersCount
{
    return [controllerArrays count];
}

-(void) setPoolWithControllers
{
    for (int i = 0; i< [self controllersCount]; i++) {
        UIViewController *cont = [controllerArrays objectAtIndex:i];
        UIView* view = cont.view;
        view.userInteractionEnabled = YES;
       
        CGFloat y = scrollView.bounds.origin.y;
        CGFloat width = scrollView.bounds.size.width;
        CGFloat height = scrollView.bounds.size.height-self.controller.navigationController.navigationBar.frame.size.height;
        view.frame = CGRectMake(width*i,y,width,height);
        [scrollView addSubview:view];
    }
}

-(UIViewController *) controllerOfIndex:(NSInteger) index
{
    return [controllerArrays objectAtIndex:index];
}

-(void) setRecognizer:(BOOL)status
{
    if (status) {
        //添加上下左右手势
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [scrollView addGestureRecognizer:swipeGestureRecognizer];
        
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [scrollView addGestureRecognizer:swipeGestureRecognizer];
        
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [scrollView addGestureRecognizer:swipeGestureRecognizer];
        
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [scrollView addGestureRecognizer:swipeGestureRecognizer];
    }
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)handle
{
    
    if(handle.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"向左滑动");
        
        
    }else if(handle.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"向右滑动");
        
        
    }else if(handle.direction == UISwipeGestureRecognizerDirectionUp)
    {
        NSLog(@"向上滑动");
        
        
    }else if(handle.direction == UISwipeGestureRecognizerDirectionDown)
    {
        NSLog(@"向下滑动");
        
    }
    
}



-(void) scrollViewDidScroll:(UIScrollView *)sender
{
    //每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    int currentPage = floor((sender.contentOffset.x - pageWidth/2)/pageWidth)+1;
    
    [_delegate acquisitionIndexAndControllerToPool:[self controllerOfIndex:currentPage] ofIndex:currentPage offset:sender.contentOffset.x];
 
}


@end
