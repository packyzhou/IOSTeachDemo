//
//  PKYellowViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKYellowViewController.h"

@interface PKYellowViewController ()

@end

@implementation PKYellowViewController

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
    UIImage *image = [UIImage imageNamed:@"CuriousFrog.png"];
    self.view.layer.contents = (id)[image CGImage];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) buttonTouch
{
    NSLog(@"黄色");
    PKSubLayer *subLayer = [[PKSubLayer alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    subLayer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subLayer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
