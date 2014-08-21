//
//  PKUILabelViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUILabelViewController.h"

@interface PKUILabelViewController ()

@end

@implementation PKUILabelViewController

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
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
    label1.text = @"text";
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 50)];
    label2.text = @"font";
    label2.font = [UIFont fontWithName:@"CourierNewPSMT" size:36];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 150, 50)];
    label3.text = @"textColor";
    label3.textColor = [UIColor blueColor];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 150, 50)];
    label4.text = @"textAlignment";
    label4.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 150, 50)];
    label5.text = @"backgroundColor";
    label5.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 100, 50)];
    label6.text = @"lineBreakMode";
    label6.lineBreakMode =  NSLineBreakByTruncatingMiddle;
    [self.view addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 100, 50)];
    label7.text = @"numberOfLines";
    label7.numberOfLines = 0;
    [self.view addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 100, 50)];
    label8.text = @"highlighted";
    label8.highlighted = YES;
    label8.highlightedTextColor = [UIColor orangeColor];
    [self.view addSubview:label8];

    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    label9.text = @"shadowSet";
    label9.shadowColor = [UIColor blueColor];
    label9.shadowOffset = CGSizeMake(1.0,1.0);
    [self.view addSubview:label9];
    
    
    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    label10.text = @"adjustsFontSizeToFitWidth";
    label10.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label10];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
