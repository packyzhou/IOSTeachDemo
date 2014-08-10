//
//  PKRedViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-18.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKRedViewController.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@interface PKRedViewController ()

@end

@implementation PKRedViewController

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
    
    
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor whiteColor] CGColor],
//                            (id)[[UIColor purpleColor] CGColor],
                            (id)[[UIColor blackColor] CGColor], nil];
//    gradientLayer.locations = [NSArray arrayWithObjects:
//                                [NSNumber numberWithFloat:0.2],
//                                [NSNumber numberWithFloat:0.3],
//                                [NSNumber numberWithFloat:0.5], nil];
    [self.view.layer addSublayer:gradientLayer];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.frame = CGRectMake(50, 250, 250, 100);
    textLayer.string = @"测试图层文字";
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.foregroundColor = [[UIColor blackColor] CGColor];
    textLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    CATransform3D rotation3D1 = CATransform3DIdentity;
    rotation3D1.m34 = 1.0/300.0f;
    rotation3D1 = CATransform3DRotate(rotation3D1, DEGREES_TO_RADIANS(60), 1.0f, 0.0f, 1.0f);
    
    self.view.layer.transform = rotation3D1;
    self.view.layer.zPosition = 300;
    
    [UIView beginAnimations:@"testAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2];
    CATransform3D rotation3D2 = CATransform3DIdentity;
    rotation3D2.m34 = 1.0/300.0f;
    rotation3D2 = CATransform3DRotate(rotation3D2, DEGREES_TO_RADIANS(-60), 1.0f, 0.0f, 1.0f);
    
    self.view.layer.transform = rotation3D2;
    self.view.layer.zPosition = 300;
    
    [UIView commitAnimations];
    [self.view.layer addSublayer:textLayer];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) buttonTouch
{
    NSLog(@"红色");
    self.button.drawStatus = ReDraw;
    [self.button setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
