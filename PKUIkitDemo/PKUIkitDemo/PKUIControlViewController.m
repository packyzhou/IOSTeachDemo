//
//  PKUIControlViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-20.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIControlViewController.h"

@interface PKUIControlViewController ()
{
    UIControl *control;
}
@end

@implementation PKUIControlViewController

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
    control = [[UIControl alloc] initWithFrame:CGRectMake(0, 64, 320, 200)];
    control.backgroundColor = [UIColor redColor];
    [self.view addSubview:control];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
