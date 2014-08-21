//
//  PKUIButtonViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-20.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIButtonViewController.h"

@interface PKUIButtonViewController ()
{
    UIButton *button;
}
@end

@implementation PKUIButtonViewController

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
    [self initUIButton];
    // Do any additional setup after loading the view from its nib.
}

-(void) initUIButton
{
    button = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 60, 30)];
    
    [button setTitle:@"按钮1" forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    
//    [button setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];
    button.titleLabel.textColor = [UIColor blackColor];
    
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 80, 100, 30);
//    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"按钮2" forState:UIControlStateNormal];
//    [button setTitleShadowColor:[UIColor blueColor] forState:UIControlStateNormal ];
//    button.titleLabel.textColor = [UIColor redColor];
    
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(200, 80, 100, 30);
    [button setImage:[UIImage imageNamed:@"main_page"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    
    [self.view addSubview:button];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
