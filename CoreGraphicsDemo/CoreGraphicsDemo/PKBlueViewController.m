//
//  PKBlueViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKBlueViewController.h"

@interface PKBlueViewController ()

@end

@implementation PKBlueViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) buttonTouch
{
    NSLog(@"蓝色");
    PKLayerView *layerView = [[PKLayerView alloc] initWithFrame:self.view.frame];
    
     [layerView setNeedsDisplay];
    [self.view addSubview:layerView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
