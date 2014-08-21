//
//  PKUIActivityIndicatorViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIActivityIndicatorViewController.h"

@interface PKUIActivityIndicatorViewController ()
{
    UIActivityIndicatorView *activityIndicatiorView;
}
@end

@implementation PKUIActivityIndicatorViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    
    activityIndicatiorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    activityIndicatiorView.center = self.view.center;
    activityIndicatiorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicatiorView];
    
    [_startButton addTarget:self action:@selector(startAnimationTodo) forControlEvents:UIControlEventTouchUpInside];
    [_endButton addTarget:self action:@selector(endAnimationTodo) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void) startAnimationTodo
{
    [activityIndicatiorView startAnimating];
}

-(void) endAnimationTodo
{
    [activityIndicatiorView stopAnimating];
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
