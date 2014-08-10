//
//  PKGreenViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKGreenViewController.h"

@interface PKGreenViewController ()
{
    PKTiledView *tiledView;
}

@end

@implementation PKGreenViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.button addTarget:self action:@selector(buttonTouch) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    [PKContext cutImageForSavePath:@"CuriousFrog" cutSize:CGSizeMake(256, 256) path:documentsDirectory];
    
    CGRect rect = self.view.frame;
    tiledView = [[PKTiledView alloc] initWithFrame:rect];
    tiledView.backgroundColor = [UIColor greenColor];
    tiledView.nextPosit = org;
    tiledView.imageName = @"CuriousFrog";
    tiledView.path =documentsDirectory;
    UIScrollView *scrollView = nil;
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = [UIImage imageNamed:@"CuriousFrog.png"].size;
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CuriousFrog.png" ]];
    
    
    [scrollView addSubview:tiledView];
    [self.view addSubview:scrollView];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
   
    tiledView.frame = CGRectMake(0, 0, self.view.frame.size.width+point.x, self.view.frame.size.height+point.y);
    [tiledView setNeedsDisplay];
}

-(void) buttonTouch
{
    tiledView.nextPosit = next;
    [tiledView setNeedsDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
