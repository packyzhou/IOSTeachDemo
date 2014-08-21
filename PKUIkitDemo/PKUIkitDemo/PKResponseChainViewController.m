//
//  PKResponseChainViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-14.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKResponseChainViewController.h"

@interface PKResponseChainViewController ()
{
    PKChainOneView *oneView;
    PKChainTwoView *twoView;
    PKChainThreeView *threeView;
}
@end

@implementation PKResponseChainViewController

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
    oneView = [[PKChainOneView alloc] initWithFrame:CGRectMake(50,40, 200, 400)];
    oneView.backgroundColor = [UIColor redColor];
    
    twoView = [[PKChainTwoView alloc ] initWithFrame:CGRectMake(0, 150, 200, 100)];
    twoView.backgroundColor = [UIColor yellowColor];
    
    threeView = [[PKChainThreeView alloc] initWithFrame:CGRectMake(0, 300, 200, 100)];
    threeView.backgroundColor = [UIColor blueColor];
    
    [oneView addSubview:twoView];
    [oneView addSubview:threeView];
    
    [self.view addSubview:oneView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.isFirstResponder) {
        NSLog(@"controller是第一响应者");
    }else
    {
        NSLog(@"controller不是第一响应者");
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
