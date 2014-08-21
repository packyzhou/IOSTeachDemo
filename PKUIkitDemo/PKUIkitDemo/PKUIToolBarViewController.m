//
//  PKUIToolBarViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIToolBarViewController.h"

@interface PKUIToolBarViewController ()
{
    UIToolbar *toolbar;
    NSArray *dataArray;
}
@end

@implementation PKUIToolBarViewController

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
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 50)];
    toolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(barbutton1)];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    customView.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    UIBarButtonItem *barButton3 = [[UIBarButtonItem alloc] initWithTitle:@"BarButton3" style:UIBarButtonItemStylePlain target:self action:@selector(barbutton3)];
    
    UIBarButtonItem *barButton4 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStyleBordered target:self action:@selector(barbutton4)];
    
    UIBarButtonItem *barButton5 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"count_tool"] landscapeImagePhone:[UIImage imageNamed:@"sport_status"] style:UIBarButtonItemStyleDone target:self action:@selector(barbutton5)];
    
    dataArray = @[barButton1,barButton2,barButton3,barButton4,barButton5];
    [toolbar setItems:dataArray animated:YES];
    [self.view addSubview: toolbar];
    // Do any additional setup after loading the view from its nib.
}

-(void) barbutton1
{
    
}
-(void) barbutton2
{
    
}
-(void) barbutton3
{
    
}
-(void) barbutton4
{
    
}
-(void) barbutton5
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
