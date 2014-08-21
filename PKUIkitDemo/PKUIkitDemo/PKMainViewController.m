//
//  PKMainViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-15.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKMainViewController.h"

@interface PKMainViewController ()
{
    UIView *oneView;
    UIView *twoView;
}
@end

@implementation PKMainViewController

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
    oneView = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 200, 150)];
    oneView.backgroundColor = [UIColor redColor];
    
    
    twoView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 200, 150)];
    twoView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:oneView];
    [self.view addSubview:twoView];
    
    [_changeButton addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void) changeView
{
//    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
//    [group setAnimations:[NSArray arrayWithObjects: [self setUpAnimation],[self setDownAnimation],nil]];
//    group.duration = 2;
//    group.fillMode =  kCAFillModeForwards;
//    group.removedOnCompletion = NO ;
    CAAnimation *oneAnimation = [self setUpAnimation];
        [oneView.layer addAnimation:oneAnimation forKey:@"oneAnimation"];
    
}

-(CAAnimation *) setUpAnimation
{
    CABasicAnimation *moverAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moverAnimation.fromValue = [NSValue valueWithCGPoint:oneView.layer.position ];
    CGPoint toPoint = CGPointMake(oneView.layer.position.x, oneView.layer.position.y-100);
    moverAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    moverAnimation.duration = 0.5;
    moverAnimation.delegate = self;
    moverAnimation.removedOnCompletion = NO ;
    moverAnimation.fillMode = kCAFillModeForwards;
    
    
    return moverAnimation;
}

-(CAAnimation *) setDownAnimation
{
    CABasicAnimation *moverAnimation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    moverAnimation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(oneView.layer.position.x, oneView.layer.position.y-100)];
    CGPoint toPoint2 = CGPointMake(oneView.layer.position.x, oneView.layer.position.y);
    moverAnimation2.toValue = [NSValue valueWithCGPoint:toPoint2];
    moverAnimation2.duration = 0.5;

//    moverAnimation2.delegate = self;
    moverAnimation2.removedOnCompletion = NO ;
//    moverAnimation2.fillMode = kCAFillModeForwards;
    return moverAnimation2;
}

-(void) animationDidStart:(CAAnimation *)anim
{
    NSLog(@"动画开始");
    
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    NSLog(@"动画[%@]结束",anim);
    CAAnimation *twoAnimation = [self setDownAnimation];
    
    NSInteger index1 = [[self.view subviews] indexOfObject:oneView];
    NSInteger index2 = [[self.view subviews] indexOfObject:twoView];
    
    [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    [oneView.layer removeAnimationForKey:@"oneAnimation"];
    [oneView.layer addAnimation:twoAnimation forKey:@"twoAnimation"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
